class RestoreMessagesTable < ActiveRecord::Migration[6.1]
  def change
    create_table :messages do |t|
      t.integer  :board_id, null: false, default: 0
      t.integer  :parent_id
      t.integer  :subject, null: false, default: ""
      t.text     :content
      t.integer  :author_id, null: false, default: 0
      t.integer  :replies_count, null: false, default: 0
      t.integer  :last_reply_id
      t.boolean  :locked, null: false, default: false
      t.boolean  :sticky, null: false, default: false
      t.datetime :created_on
      t.datetime :updated_on
    end
    add_index :messages, :board_id
    add_index :messages, :parent_id
    add_index :messages, :author_id
    add_index :messages, :last_reply_id
  end
end 