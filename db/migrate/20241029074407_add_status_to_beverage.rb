class AddStatusToBeverage < ActiveRecord::Migration[7.2]
  def change
    add_column :beverages, :status, :boolean, default: true
  end
end
