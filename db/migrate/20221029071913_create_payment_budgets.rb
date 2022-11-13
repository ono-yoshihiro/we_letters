class CreatePaymentBudgets < ActiveRecord::Migration[6.1]
  def change
    create_table :payment_budgets do |t|
      t.integer :section_id, null: false
      t.integer :budget_id, null: false
      t.boolean :is_deleted, default: false
      t.timestamps
    end
  end
end
