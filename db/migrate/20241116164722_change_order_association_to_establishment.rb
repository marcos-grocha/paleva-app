class ChangeOrderAssociationToEstablishment < ActiveRecord::Migration[7.2]
  def change
    add_reference :orders, :establishment, null: false, foreign_key: true
    remove_reference :orders, :user_owner, foreign_key: true
  end
end
