class CreateOptions < ActiveRecord::Migration[6.1]
  def change
    create_table :options do |t|
      t.string :name, null: false
      t.integer :additional_price, null: false
      t.timestamps
    end
  end
end
