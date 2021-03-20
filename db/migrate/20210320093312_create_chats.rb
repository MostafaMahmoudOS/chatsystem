class CreateChats < ActiveRecord::Migration[5.2]
  def change
    create_table :chats do |t|
      t.string :name
      t.integer :chat_number
      t.integer :messages_count
      t.references :application, foreign_key: true
      t.timestamps
    end
    create_join_table :chats, :users do |t|
      t.references :chat, foreign_key: true
      t.references :user, foreign_key: true
    end
  end
end
