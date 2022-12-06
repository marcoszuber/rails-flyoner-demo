class AddTypeToUser < ActiveRecord::Migration[7.0]
  def change
    add_column :users, :owner, :boolean
    add_column :users, :client, :boolean
  end
end
