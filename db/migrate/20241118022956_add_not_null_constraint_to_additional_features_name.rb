class AddNotNullConstraintToAdditionalFeaturesName < ActiveRecord::Migration[7.2]
  def change
    change_column_null :additional_features, :name, false
  end
end
