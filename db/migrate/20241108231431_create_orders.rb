class CreateOrders < ActiveRecord::Migration[7.2]
  def change
    create_table :orders do |t|
      t.string :customer_name, null: false
      t.string :contact_phone
      t.string :contact_email
      t.string :cpf
      t.integer :status
      t.string :order_code
      t.references :user_owner, null: false, foreign_key: true

      t.timestamps
    end
  end
end
