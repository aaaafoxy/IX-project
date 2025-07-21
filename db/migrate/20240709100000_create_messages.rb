class CreateNotifications < ActiveRecord::Migration[6.1]
  def change
    create_table :notifications do |t|
      t.integer :user_id, null: false
      t.string :message_type
      t.text :content
      t.string :link
      t.boolean :read, default: false
      t.timestamps
    end
    add_index :notifications, :user_id
    add_index :notifications, :read
  end
end 