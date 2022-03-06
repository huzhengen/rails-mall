class CreateOrders < ActiveRecord::Migration[5.2]
  def change
    create_table :orders do |t|
      t.integer :user_id
      t.integer :product_id
      t.integer :address_id
      t.integer :amount
      t.string :order_no
      t.decimal :total_money, precision: 10, scale: 2
      t.datetime :payment_at

      t.timestamps
    end

    add_index :orders, [:user_id]
    add_index :orders, [:order_no], unique: true
  end
end
