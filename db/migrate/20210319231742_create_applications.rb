class CreateApplications < ActiveRecord::Migration[5.2]
  def change
    create_table :applications do |t|
      t.string :name
      t.string :token
      t.integer :chats_number
      t.references :client, foreign_key: true

      t.timestamps
    end
  end
end
