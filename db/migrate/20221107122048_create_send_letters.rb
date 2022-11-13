class CreateSendLetters < ActiveRecord::Migration[6.1]
  def change
    create_table :send_letters do |t|
      t.integer :section_id, null: false
      t.integer :payment_budget_id, null: false
      t.integer :total_price
      t.boolean :status, default: false
      t.timestamps
    end
  end
end