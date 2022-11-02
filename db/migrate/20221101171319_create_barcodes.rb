class CreateBarcodes < ActiveRecord::Migration[6.1]
  def change
    create_table :barcodes do |t|
      t.string :barcode, null: false
      t.timestamps
    end
  end
end
