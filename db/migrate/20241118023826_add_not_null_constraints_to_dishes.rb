class AddNotNullConstraintsToDishes < ActiveRecord::Migration[7.2]
  def change
    change_column_null :dishes, :name, false
    change_column_null :dishes, :description, false
  end
end
