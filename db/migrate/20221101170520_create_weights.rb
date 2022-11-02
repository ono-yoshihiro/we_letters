class CreateWeights < ActiveRecord::Migration[6.1]
  def change
    create_table :weights do |t|
      t.string :weight
      t.timestamps
    end
  end
end
