class AddDatesReasonToOrders < ActiveRecord::Migration[7.2]
  def change
    add_column :orders, :in_preparation_date, :datetime
    add_column :orders, :ready_date, :datetime
  end
end
