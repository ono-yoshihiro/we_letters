class CreateOptions < ActiveRecord::Migration[6.1]
  def change
    create_table :options do |t|
      t.string :name, null: false
      t.integer :additional_price_1, null: false
      t.integer :additional_price_2
      t.integer :additional_price_3
      t.integer :additional_price_4
      t.timestamps
    end
  end
end
