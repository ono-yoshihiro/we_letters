class CreateCombinations < ActiveRecord::Migration[6.1]
  def change
    create_table :combinations do |t|
      t.integer :option_id, null: false
      t.integer :letter_id, null: false
      t.timestamps
    end
  end
end
