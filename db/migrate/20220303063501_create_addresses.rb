class CreateAddresses < ActiveRecord::Migration[5.2]
  def change
    create_table :addresses do |t|
      t.integer :user_id
      t.string :address_type
      t.string :address
      t.string :contact_name
      t.string :cellphone
      t.string :zipcode

      t.timestamps
    end

    add_index :addresses, [:user_id, :address_type]
  end
end
