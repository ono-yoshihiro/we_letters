class CreateRegisteredOptions < ActiveRecord::Migration[6.1]
  def change
    create_table :registered_options do |t|
      t.string :option, null: false
      t.timestamps
    end
  end
end
