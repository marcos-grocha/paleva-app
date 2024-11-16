class FixMenusIndex < ActiveRecord::Migration[7.2]
  def change
    remove_index :menus, name: "index_menus_on_name_and_user_owner_id"
    add_index :menus, [:name, :establishment_id], unique: true
  end
end
