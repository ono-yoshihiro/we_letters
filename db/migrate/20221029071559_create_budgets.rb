class CreateBudgets < ActiveRecord::Migration[6.1]
  def change
    create_table :budgets do |t|
      t.string :name, null: false
      t.boolean :is_deleted, default: false
      t.timestamps
    end
  end
end
