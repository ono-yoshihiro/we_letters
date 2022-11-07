class CreateDeliveryDateOptions < ActiveRecord::Migration[6.1]
  def change
    create_table :delivery_date_options do |t|
      t.string :option, null: false
      t.timestamps
    end
  end
end
