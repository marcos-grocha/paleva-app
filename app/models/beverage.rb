class Beverage < ApplicationRecord
  belongs_to :establishment
  has_one_attached :photo
  has_many :portions

  validates :name, :description, presence: true
end
