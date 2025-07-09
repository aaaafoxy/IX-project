class AddIssueAssignees < ActiveRecord::Migration[6.1]
  def change
    create_table :issue_assignees do |t|
      t.references :issue, null: false, foreign_key: true
      t.references :user, null: false, foreign_key: true
      t.timestamps
    end
    add_index :issue_assignees, [:issue_id, :user_id], unique: true
  end
end 