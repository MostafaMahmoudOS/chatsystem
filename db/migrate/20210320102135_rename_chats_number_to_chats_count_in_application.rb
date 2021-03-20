class RenameChatsNumberToChatsCountInApplication < ActiveRecord::Migration[5.2]
  def self.up
    rename_column :applications, :chats_number, :chats_count
  end

  def self.down
    rename_column :applications, :chats_count, :chats_number
  end
end
