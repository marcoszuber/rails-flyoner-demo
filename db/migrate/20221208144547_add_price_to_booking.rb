class AddPriceToBooking < ActiveRecord::Migration[7.0]
  def change
    add_column :bookings, :total_price, :integer, default: 0
  end
end
