class ChangeColumnToNull < ActiveRecord::Migration[6.1]
  def up
    change_column_null :sections, :status, true
  end
end