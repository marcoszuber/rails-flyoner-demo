class CreateEmptyLegs < ActiveRecord::Migration[7.0]
  def change
    create_table :empty_legs do |t|
      t.string :from
      t.string :to
      t.datetime :date
      t.integer :seat_available

      t.timestamps
    end
  end
end
