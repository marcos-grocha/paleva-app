class AddStatusToMenus < ActiveRecord::Migration[7.2]
  def change
    add_column :menus, :status, :boolean, default: true, null: false
  end
end
