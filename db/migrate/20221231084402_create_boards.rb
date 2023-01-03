class CreateBoards < ActiveRecord::Migration[6.1]
  def change
    create_table :boards do |t|
      t.integer :section_id
      t.string :title, null: false
      t.string :body, null: false
      t.timestamps
    end
  end
end
