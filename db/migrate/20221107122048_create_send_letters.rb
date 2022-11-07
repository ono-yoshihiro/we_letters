class CreateSendLetters < ActiveRecord::Migration[6.1]
  def change
    create_table :send_letters do |t|
      t.integer :section_id, null: false
      t.integer :budget_name, null: false
      t.integer :number, null: false
      t.timestamps
    end
  end
end
