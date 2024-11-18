class AddNotNullConstraintsToBeverages < ActiveRecord::Migration[7.2]
  def change
    change_column_null :beverages, :name, false
    change_column_null :beverages, :description, false
  end
end
