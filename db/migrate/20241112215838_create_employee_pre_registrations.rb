class CreateEmployeePreRegistrations < ActiveRecord::Migration[7.2]
  def change
    create_table :employee_pre_registrations do |t|
      t.string :email, null: false
      t.string :cpf, null: false
      t.references :user_owner, null: false, foreign_key: true
      t.references :establishment, null: false, foreign_key: true
      t.boolean :status, default: false

      t.timestamps
    end
    add_index :employee_pre_registrations, :email, unique: true
    add_index :employee_pre_registrations, :cpf, unique: true
  end
end
