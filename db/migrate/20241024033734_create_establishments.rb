class CreateEstablishments < ActiveRecord::Migration[7.2]
  def change
    create_table :establishments do |t|
      t.string :fantasy_name
      t.string :corporate_name
      t.string :cnpj
      t.string :address
      t.integer :telephone
      t.string :email
      t.string :code
      t.references :user_owner, null: false, foreign_key: true

      t.timestamps
    end
  end
end
