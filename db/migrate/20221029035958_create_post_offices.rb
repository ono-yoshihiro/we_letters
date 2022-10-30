class CreatePostOffices < ActiveRecord::Migration[6.1]
  def change
    create_table :post_offices do |t|
      t.string :name, null: false
      t.string :postal_code, null: false
      t.timestamps
    end
  end
end
