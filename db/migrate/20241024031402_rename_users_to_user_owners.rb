class RenameUsersToUserOwners < ActiveRecord::Migration[7.2]
  def change
    rename_table :users, :user_owners
  end
end
