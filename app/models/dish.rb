class Dish < ApplicationRecord
  belongs_to :establishment
  has_one_attached :photo
  has_many :portions, dependent: :destroy
  has_many :additional_features, dependent: :destroy

  validates :name, :description, presence: true
end
