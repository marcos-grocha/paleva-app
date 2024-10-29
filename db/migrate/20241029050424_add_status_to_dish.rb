class AddStatusToDish < ActiveRecord::Migration[7.2]
  def change
    add_column :dishes, :status, :boolean, default: true
  end
end
