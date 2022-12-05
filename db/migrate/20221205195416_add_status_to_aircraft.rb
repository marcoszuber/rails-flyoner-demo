class AddStatusToAircraft < ActiveRecord::Migration[7.0]
  def change
    add_column :aircrafts, :status, :boolean
  end
end
