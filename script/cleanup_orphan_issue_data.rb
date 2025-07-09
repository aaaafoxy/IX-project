#!/usr/bin/env ruby
# 用于清理与已删除项目下 issues 相关的 orphan 数据
require File.expand_path('../../config/environment', __FILE__)

# 1. 找到所有已删除项目的 issue id
project_ids = Project.unscoped.where(status: Project::STATUS_ARCHIVED).pluck(:id)
issue_ids = Issue.unscoped.where(project_id: project_ids).pluck(:id)

puts "已归档/删除项目ID: #{project_ids.inspect}"
puts "相关 issue ID: #{issue_ids.inspect}"

if issue_ids.empty?
  puts '无 orphan issue，无需清理。'
  exit 0
end

# 2. 清理 attachments（多态）
count = Attachment.where(container_type: 'Issue', container_id: issue_ids).delete_all
puts "已删除 attachments: #{count}"

# 3. 清理 custom_values（多态）
count = CustomValue.where(customized_type: 'Issue', customized_id: issue_ids).delete_all
puts "已删除 custom_values: #{count}"

# 4. 清理 watchers（多态）
count = Watcher.where(watchable_type: 'Issue', watchable_id: issue_ids).delete_all
puts "已删除 watchers: #{count}"

# 5. 清理其它插件表（如有）
if defined?(IssueChecklist)
  count = IssueChecklist.where(issue_id: issue_ids).delete_all
  puts "已删除 issue_checklists: #{count}"
end
if defined?(Worklog)
  count = Worklog.where(issue_id: issue_ids).delete_all
  puts "已删除 worklogs: #{count}"
end

puts 'orphan issue 相关数据清理完成！' 