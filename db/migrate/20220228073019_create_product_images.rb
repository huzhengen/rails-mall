class CreateProductImages < ActiveRecord::Migration[5.2]
  def change
    create_table :product_images do |t|
      t.belongs_to :product
      t.attachment :image
      t.integer :weight

      t.timestamps
    end
  end
end
