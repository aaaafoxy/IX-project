class CascadeWorklogsIssueFk < ActiveRecord::Migration[6.1]
  def up
    if foreign_key_exists?(:worklogs, :issues)
      remove_foreign_key :worklogs, :issues
    end
    add_foreign_key :worklogs, :issues, on_delete: :cascade
  end

  def down
    remove_foreign_key :worklogs, :issues
    add_foreign_key :worklogs, :issues
  end
end 