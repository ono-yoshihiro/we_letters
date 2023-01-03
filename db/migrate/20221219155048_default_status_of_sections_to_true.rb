class DefaultStatusOfSectionsToTrue < ActiveRecord::Migration[6.1]
  def change
    change_column_default :sections, :status, from: false, to: true
  end
end
