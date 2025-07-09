class AddActivityAndAuthorToWorklogs < ActiveRecord::Migration[6.1]
  def change
    add_column :worklogs, :activity_id, :integer, null: false, default: 1
    add_column :worklogs, :author_id, :integer, null: false, default: 1
  end
end 