class RenameRestaurantOwnersToUsers < ActiveRecord::Migration[7.2]
  def change
    rename_table :restaurant_owners, :users
  end
end
