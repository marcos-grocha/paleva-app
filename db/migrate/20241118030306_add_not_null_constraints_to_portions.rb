class AddNotNullConstraintsToPortions < ActiveRecord::Migration[7.2]
  def change
    change_column_null :portions, :description, false
    change_column_null :portions, :price, false
  end
end
