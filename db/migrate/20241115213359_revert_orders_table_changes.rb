class RevertOrdersTableChanges < ActiveRecord::Migration[7.2]
  def change
    change_table :orders do |t|
      t.remove_references :user_employee, null: true, foreign_key: true
      t.remove_references :menu, null: false, foreign_key: true
    end
  end
end
