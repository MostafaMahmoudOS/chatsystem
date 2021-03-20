class AddDefaultZeroToMessagesCountToChat < ActiveRecord::Migration[5.2]
  def self.up
    change_column_default :chats, :messages_count, from: nil,  to: 0
  end

  def self.down
    change_column_default :chats, :messages_count, from: 0,  to: nil
  end
end
