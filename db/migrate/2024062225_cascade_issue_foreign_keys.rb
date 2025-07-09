class CascadeIssueForeignKeys < ActiveRecord::Migration[6.1]
  def up
    # journals(issue_id)
    if foreign_key_exists?(:journals, :issues)
      remove_foreign_key :journals, :issues
      add_foreign_key :journals, :issues, on_delete: :cascade
    end
    # journal_details(journal_id)
    if foreign_key_exists?(:journal_details, :journals)
      remove_foreign_key :journal_details, :journals
      add_foreign_key :journal_details, :journals, on_delete: :cascade
    end
    # attachments(container_id) 只处理 container_type='Issue' 的情况，需手动处理
    # issue_relations(issue_from_id, issue_to_id)
    if foreign_key_exists?(:issue_relations, :issues, column: :issue_from_id)
      remove_foreign_key :issue_relations, column: :issue_from_id
      add_foreign_key :issue_relations, :issues, column: :issue_from_id, on_delete: :cascade
    end
    if foreign_key_exists?(:issue_relations, :issues, column: :issue_to_id)
      remove_foreign_key :issue_relations, column: :issue_to_id
      add_foreign_key :issue_relations, :issues, column: :issue_to_id, on_delete: :cascade
    end
    # custom_values(customized_id) 只处理 customized_type='Issue' 的情况，需手动处理
    # watchers(watchable_id) 只处理 watchable_type='Issue' 的情况，需手动处理
    # time_entries(issue_id)
    if foreign_key_exists?(:time_entries, :issues)
      remove_foreign_key :time_entries, :issues
      add_foreign_key :time_entries, :issues, on_delete: :cascade
    end
  end

  def down
    # 恢复为默认外键（无级联）
    if foreign_key_exists?(:journals, :issues)
      remove_foreign_key :journals, :issues
      add_foreign_key :journals, :issues
    end
    if foreign_key_exists?(:journal_details, :journals)
      remove_foreign_key :journal_details, :journals
      add_foreign_key :journal_details, :journals
    end
    if foreign_key_exists?(:issue_relations, :issues, column: :issue_from_id)
      remove_foreign_key :issue_relations, column: :issue_from_id
      add_foreign_key :issue_relations, :issues, column: :issue_from_id
    end
    if foreign_key_exists?(:issue_relations, :issues, column: :issue_to_id)
      remove_foreign_key :issue_relations, column: :issue_to_id
      add_foreign_key :issue_relations, :issues, column: :issue_to_id
    end
    if foreign_key_exists?(:time_entries, :issues)
      remove_foreign_key :time_entries, :issues
      add_foreign_key :time_entries, :issues
    end
  end
end 