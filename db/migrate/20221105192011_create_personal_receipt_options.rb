class CreatePersonalReceiptOptions < ActiveRecord::Migration[6.1]
  def change
    create_table :personal_receipt_options do |t|
      t.string :option, null: false
      t.timestamps
    end
  end
end
