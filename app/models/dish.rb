class Dish < ApplicationRecord
  belongs_to :establishment

  validates :name, :description, presence: true
end
