class CreateProofDeliveryOptions < ActiveRecord::Migration[6.1]
  def change
    create_table :proof_delivery_options do |t|
      t.string :option, null: false
      t.timestamps
    end
  end
end
