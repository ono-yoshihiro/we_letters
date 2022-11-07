class CreateTypeNames < ActiveRecord::Migration[6.1]
  def change
    create_table :type_names do |t|
      t.string :type_name, null: false
      t.timestamps
    end
  end
end
