class AllowNullForDishIdAndBeverageIdInPortions < ActiveRecord::Migration[7.2]
  def change
    change_column_null :portions, :dish_id, true
    change_column_null :portions, :beverage_id, true
  end
end
