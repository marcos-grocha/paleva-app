class CreateAdditionalFeatures < ActiveRecord::Migration[7.2]
  def change
    create_table :additional_features do |t|
      t.string :name
      t.boolean :active
      t.references :dish, null: false, foreign_key: true

      t.timestamps
    end
  end
end
