class CreateMenuBeverages < ActiveRecord::Migration[7.2]
  def change
    create_table :menu_beverages do |t|
      t.references :menu, null: false, foreign_key: true
      t.references :beverage, null: false, foreign_key: true

      t.timestamps
    end
  end
end
