class Beverage < ApplicationRecord
  belongs_to :establishment
  has_one_attached :photo

  validates :name, :description, presence: true
end
