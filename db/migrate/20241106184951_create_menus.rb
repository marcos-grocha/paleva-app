class CreateMenus < ActiveRecord::Migration[7.2]
  def change
    create_table :menus do |t|
      t.string :name, null: false
      t.references :user_owner, null: false, foreign_key: true

      t.timestamps
    end
    add_index :menus, [:name, :user_owner_id], unique: true
  end
end
