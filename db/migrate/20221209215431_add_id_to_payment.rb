class AddIdToPayment < ActiveRecord::Migration[7.0]
  def change
    add_column :payments, :mp_id, :integer
  end
end
