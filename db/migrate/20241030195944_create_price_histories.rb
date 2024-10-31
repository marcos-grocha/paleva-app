class CreatePriceHistories < ActiveRecord::Migration[7.2]
  def change
    create_table :price_histories do |t|
      t.string :description_was
      t.string :price_was
      t.datetime :registration_date
      t.references :portion, null: false, foreign_key: true

      t.timestamps
    end
  end
end
