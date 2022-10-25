class CreateTypes < ActiveRecord::Migration[6.1]
  def change
    create_table :types do |t|
      t.string :name, null: false
      t.integer :price, null: false
      t.integer :special_price_1
      t.integer :special_price_2
      t.integer :special_price_3
      t.integer :special_price_4
      t.timestamps
    end
  end
end