class CreateWorklogs < ActiveRecord::Migration[6.1]
  def change
    create_table :worklogs do |t|
      t.references :user, null: false, foreign_key: true
      t.references :project, null: false, foreign_key: true
      t.references :issue, foreign_key: true
      t.date :date, null: false
      t.decimal :hours, precision: 4, scale: 2, null: false
      t.string :remark
      t.timestamps
    end
  end
end 