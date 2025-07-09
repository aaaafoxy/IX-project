class AddCurrentVersionIdToProjectFiles < ActiveRecord::Migration[6.1]
  def change
    add_column :project_files, :current_version_id, :integer
  end
end
