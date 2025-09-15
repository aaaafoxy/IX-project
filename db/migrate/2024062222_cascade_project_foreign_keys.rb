class CascadeProjectForeignKeys < ActiveRecord::Migration[6.1]
  def up
    # issues
    if foreign_key_exists?(:issues, :projects)
      remove_foreign_key :issues, :projects
    end
    add_foreign_key :issues, :projects, on_delete: :cascade

    # time_entries
    if foreign_key_exists?(:time_entries, :projects)
      remove_foreign_key :time_entries, :projects
    end
    add_foreign_key :time_entries, :projects, on_delete: :cascade

    # members
    if foreign_key_exists?(:members, :projects)
      remove_foreign_key :members, :projects
    end
    add_foreign_key :members, :projects, on_delete: :cascade

    # documents
    if foreign_key_exists?(:documents, :projects)
      remove_foreign_key :documents, :projects
    end
    add_foreign_key :documents, :projects, on_delete: :cascade

    # news
    if foreign_key_exists?(:news, :projects)
      remove_foreign_key :news, :projects
    end
    add_foreign_key :news, :projects, on_delete: :cascade

    # worklogs（如有）
    if table_exists?(:worklogs) && foreign_key_exists?(:worklogs, :projects)
      remove_foreign_key :worklogs, :projects
      add_foreign_key :worklogs, :projects, on_delete: :cascade
    end
  end

  def down
    # 恢复原有的外键约束（不设置级联删除）
    if foreign_key_exists?(:issues, :projects)
      remove_foreign_key :issues, :projects
      add_foreign_key :issues, :projects
    end

    if foreign_key_exists?(:time_entries, :projects)
      remove_foreign_key :time_entries, :projects
      add_foreign_key :time_entries, :projects
    end

    if foreign_key_exists?(:members, :projects)
      remove_foreign_key :members, :projects
      add_foreign_key :members, :projects
    end

    if foreign_key_exists?(:documents, :projects)
      remove_foreign_key :documents, :projects
      add_foreign_key :documents, :projects
    end

    if foreign_key_exists?(:news, :projects)
      remove_foreign_key :news, :projects
      add_foreign_key :news, :projects
    end

    if table_exists?(:worklogs) && foreign_key_exists?(:worklogs, :projects)
      remove_foreign_key :worklogs, :projects
      add_foreign_key :worklogs, :projects
    end
  end
end 