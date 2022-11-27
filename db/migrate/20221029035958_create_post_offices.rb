class CreatePostOffices < ActiveRecord::Migration[6.1]
  def change
    create_table :post_offices do |t|
      t.string :post_office_name, null: false
      t.string :postal_code, null: false
      t.string :sender_name, null: false
      t.string :customer_number, null: false
      t.timestamps
    end
  end
end
