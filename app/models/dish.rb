class Dish < ApplicationRecord
  belongs_to :establishment
  has_one_attached :photo
  has_many :portions, dependent: :destroy
  has_many :additional_features, dependent: :destroy
  has_many :menu_dishes, dependent: :destroy
  has_many :menus, through: :menu_dishes
  has_many :order_items

  validates :name, :description, presence: true
end
