class AddReferencesToBooking < ActiveRecord::Migration[7.0]
  def change
    add_reference :bookings, :review_aircraft, null: true, foreign_key: true
    add_reference :bookings, :payment, null: true, foreign_key: true
  end
end
