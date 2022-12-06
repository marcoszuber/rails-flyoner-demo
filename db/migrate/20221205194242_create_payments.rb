class CreatePayments < ActiveRecord::Migration[7.0]
  def change
    create_table :payments do |t|
      t.string :status
      t.string :status_detail
      t.integer :merchant_order_id
      t.string :processing_mode

      t.timestamps
    end
  end
end
