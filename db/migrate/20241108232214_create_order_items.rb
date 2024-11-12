class CreateOrderItems < ActiveRecord::Migration[7.2]
  def change
    create_table :order_items do |t|
      t.references :order, null: false, foreign_key: true
      t.references :dish, foreign_key: true
      t.references :beverage, foreign_key: true
      t.references :portion, foreign_key: true
      t.integer :quantity, null: false, default: 1
      t.text :note

      t.timestamps
    end
  end
end
