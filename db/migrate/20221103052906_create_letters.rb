class CreateLetters < ActiveRecord::Migration[6.1]
  def change
    create_table :letters do |t|
      t.integer :section_id, null: false
      t.integer :type_id, null: false
      t.integer :number, null: false
      t.timestamps
    end
  end
end