class CreateLetterDetails < ActiveRecord::Migration[6.1]
  def change
    create_table :letter_details do |t|
      t.integer :send_letter_id, null: false
      t.integer :type_id, null: false
      t.integer :applicable_price
      t.integer :number, null: false
      t.timestamps
    end
  end
end