class CreateTypes < ActiveRecord::Migration[6.1]
  def change
    create_table :types do |t|
      t.integer :type_name_id, null: false
      t.integer :weight_id
      t.integer :size_id
      t.integer :address_id
      t.integer :barcode_id
      t.integer :price, null: false
      t.integer :special_price_1
      t.integer :special_price_2
      t.integer :special_price_3
      t.timestamps
    end
  end
end