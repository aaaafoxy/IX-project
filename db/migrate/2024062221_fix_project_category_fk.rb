class FixProjectCategoryFk < ActiveRecord::Migration[6.1]
  def up
    # 移除原有外键（如果存在）
    if foreign_key_exists?(:projects, :enumerations, column: :project_category_id)
      remove_foreign_key :projects, column: :project_category_id
    end
    # 重新添加外键，删除分类时自动置空
    add_foreign_key :projects, :enumerations, column: :project_category_id, on_delete: :nullify
  end

  def down
    # 恢复原有的外键约束
    if foreign_key_exists?(:projects, :enumerations, column: :project_category_id)
      remove_foreign_key :projects, column: :project_category_id
      add_foreign_key :projects, :enumerations, column: :project_category_id
    end
  end
end 