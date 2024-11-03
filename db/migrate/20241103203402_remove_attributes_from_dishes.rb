class RemoveAttributesFromDishes < ActiveRecord::Migration[7.2]
  def change
    remove_column :dishes, :vegetarian, :boolean
    remove_column :dishes, :vegan, :boolean
    remove_column :dishes, :gluten_free, :boolean
    remove_column :dishes, :sugar_free, :boolean
    remove_column :dishes, :spicy, :boolean
  end
end
