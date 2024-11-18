class AddNotNullConstraintsToEstablishments < ActiveRecord::Migration[7.2]
  def change
    change_column_null :establishments, :fantasy_name, false
    change_column_null :establishments, :corporate_name, false
    change_column_null :establishments, :cnpj, false
    change_column_null :establishments, :address, false
    change_column_null :establishments, :telephone, false
    change_column_null :establishments, :email, false
  end
end
