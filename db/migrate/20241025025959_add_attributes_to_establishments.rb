class AddAttributesToEstablishments < ActiveRecord::Migration[7.2]
  def change
    add_column :establishments, :sunday, :boolean
    add_column :establishments, :monday, :boolean
    add_column :establishments, :tuesday, :boolean
    add_column :establishments, :wednesday, :boolean
    add_column :establishments, :thursday, :boolean
    add_column :establishments, :friday, :boolean
    add_column :establishments, :saturday, :boolean
    add_column :establishments, :opening_time, :time
    add_column :establishments, :closing_time, :time
  end
end
