class Worklog < ActiveRecord::Base
  belongs_to :user
  belongs_to :project
  belongs_to :issue, optional: true
  belongs_to :activity, class_name: 'TimeEntryActivity', foreign_key: 'activity_id'

  validates :user_id, :project_id, :date, :hours, :activity_id, :author_id, presence: true
  validates :hours, numericality: { greater_than: 0, less_than_or_equal_to: 24 }

  after_create :sync_to_time_entries
  after_update :update_time_entry
  after_destroy :destroy_time_entry

  # 可选：记录同步的 time_entry_id，便于后续操作
  # add_column :worklogs, :time_entry_id, :integer

  private
  def sync_to_time_entries
    time_entry = TimeEntry.new(
      project_id: self.project_id,
      user_id: self.user_id,
      issue_id: self.issue_id,
      hours: self.hours,
      comments: self.remark,
      activity_id: self.activity_id,
      spent_on: self.date,
      author_id: self.author_id
    )
    if time_entry.save
      # 可选：保存 time_entry_id
      # self.update_column(:time_entry_id, time_entry.id)
    else
      Rails.logger.error "Worklog同步TimeEntry失败: #{time_entry.errors.full_messages.join(', ')}"
      # 业务可选：如需强一致性可回滚
      # raise ActiveRecord::Rollback
    end
  end

  def update_time_entry
    # 若有 time_entry_id 字段可直接查找，否则用同步条件查找
    time_entry = TimeEntry.where(
      project_id: self.project_id,
      user_id: self.user_id,
      issue_id: self.issue_id,
      spent_on: self.date,
      author_id: self.author_id
    ).order(created_on: :desc).first
    if time_entry
      time_entry.update(
        hours: self.hours,
        comments: self.remark,
        activity_id: self.activity_id
      )
    else
      Rails.logger.warn "Worklog更新未找到对应TimeEntry，自动补同步。"
      sync_to_time_entries
    end
  end

  def destroy_time_entry
    time_entry = TimeEntry.where(
      project_id: self.project_id,
      user_id: self.user_id,
      issue_id: self.issue_id,
      spent_on: self.date,
      author_id: self.author_id
    ).order(created_on: :desc).first
    if time_entry
      time_entry.destroy
    else
      Rails.logger.warn "Worklog删除未找到对应TimeEntry。"
    end
  end
end 