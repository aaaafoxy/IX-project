class ProjectCategoryToProjects < ActiveRecord::Migration[6.1]
  def up
    add_column :projects, :project_category_id, :integer
    add_index :projects, :project_category_id

    # 查找"内部自用"分类，没有则创建
    category = ProjectCategory.where(name: '内部自用').first
    unless category
      category = ProjectCategory.create!(name: '内部自用', is_default: true, active: true)
    end
    # 所有项目赋值
    Project.update_all(project_category_id: category.id)
  end

  def down
    remove_index :projects, :project_category_id
    remove_column :projects, :project_category_id
  end
end 