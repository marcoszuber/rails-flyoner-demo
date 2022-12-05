class CreateReviewAircrafts < ActiveRecord::Migration[7.0]
  def change
    create_table :review_aircrafts do |t|
      t.float :stars
      t.text :description
      t.references :aircraft, null: false, foreign_key: true

      t.timestamps
    end
  end
end
