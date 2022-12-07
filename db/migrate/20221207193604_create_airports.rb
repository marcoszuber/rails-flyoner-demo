class CreateAirports < ActiveRecord::Migration[7.0]
  def change
    create_table :airports do |t|
      t.string :name
      t.float :lat
      t.float :lon
      t.string :layer
      t.integer :quantity
      t.string :continent
      t.string :country
      t.string :region
      t.string :code

      t.timestamps
    end
  end
end
