class CreateAircrafts < ActiveRecord::Migration[7.0]
  def change
    create_table :aircrafts do |t|
      t.string :name
      t.integer :price
      t.integer :seats
      t.text :description
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
