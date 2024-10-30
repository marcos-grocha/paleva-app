class AddAttributesToDish < ActiveRecord::Migration[7.2]
  def change
    add_column :dishes, :vegetarian, :boolean, default: false
    add_column :dishes, :vegan, :boolean, default: false
    add_column :dishes, :gluten_free, :boolean, default: false
    add_column :dishes, :sugar_free, :boolean, default: false
    add_column :dishes, :spicy, :boolean, default: false
  end
end
