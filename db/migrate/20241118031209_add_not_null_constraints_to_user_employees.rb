class AddNotNullConstraintsToUserEmployees < ActiveRecord::Migration[7.2]
  def change
    change_column_null :user_employees, :name, false
    change_column_null :user_employees, :last_name, false
  end
end
