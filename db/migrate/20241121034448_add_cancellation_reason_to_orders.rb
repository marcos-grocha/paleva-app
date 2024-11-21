class AddCancellationReasonToOrders < ActiveRecord::Migration[7.2]
  def change
    add_column :orders, :cancellation_reason, :string
  end
end
