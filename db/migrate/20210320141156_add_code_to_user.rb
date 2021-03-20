class AddCodeToUser < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :code, :string
  end
end
