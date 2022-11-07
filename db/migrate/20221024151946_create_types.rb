class CreateTypes < ActiveRecord::Migration[6.1]
  def change
    create_table :types do |t|
      t.integer :type_name_id, null: false
      t.integer :weight_id, null: false
      t.integer :size_id, null: false
      t.integer :address_id, null: false
      t.integer :barcode_id, null: false
      t.integer :price, null: false
      t.integer :special_price_1, null: false
      t.integer :special_price_2, null: false
      t.integer :special_price_3, null: false
      t.integer :delivery_date_option_id, null: false
      t.integer :delivery_date_option_price, null: false
      t.integer :registered_option_id, null: false
      t.integer :registered_option_price, null: false
      t.integer :proof_delivery_option_id, null: false
      t.integer :proof_delivery_option_price, null: false
      t.integer :proof_contents_option_id, null: false
      t.integer :proof_contents_option_price, null: false
      t.integer :personal_receipt_option_id, null: false
      t.integer :personal_receipt_option_price, null: false
      t.timestamps
    end
  end
end