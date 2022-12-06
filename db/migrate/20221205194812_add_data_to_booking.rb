class AddDataToBooking < ActiveRecord::Migration[7.0]
  def change
    add_column :bookings, :from, :string
    add_column :bookings, :to, :string
    add_reference :bookings, :empty_leg, null: true, foreign_key: true
  end
end
