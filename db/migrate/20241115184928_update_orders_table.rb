class UpdateOrdersTable < ActiveRecord::Migration[7.2]
  def change
    change_table :orders do |t|
      t.change :status, :integer, default: 0
      t.references :user_employee, null: true, foreign_key: true
      t.references :menu, null: false, foreign_key: true
    end
  end
end
