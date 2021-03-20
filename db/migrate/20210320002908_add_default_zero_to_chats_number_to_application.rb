class AddDefaultZeroToChatsCountToApplication < ActiveRecord::Migration[5.2]
  def change
    change_column_default :applications, :chats_number, from: nil,  to: 0
  end
end
