class ChangeMenuAssociationToEstablishment < ActiveRecord::Migration[7.2]
  def change
    add_reference :menus, :establishment, null: true, foreign_key: true
    remove_reference :menus, :user_owner, foreign_key: true
    
    change_column_null :menus, :establishment_id, false
  end
end
