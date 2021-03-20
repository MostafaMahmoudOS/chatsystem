class CreateMessages < ActiveRecord::Migration[5.2]
  def change
    create_table :messages do |t|
      t.text :body
      t.integer :message_number
      t.timestamps
    end
    add_reference :messages, :sender, references: :users, index: true
    add_foreign_key :messages, :users, column: :sender_id
    add_reference :messages, :chat, references: :chats, index: true
    add_foreign_key :messages, :chats, column: :chat_id
  end
end
