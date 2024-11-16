class Beverage < ApplicationRecord
  belongs_to :establishment
  has_one_attached :photo
  has_many :portions
  has_many :menu_beverages, dependent: :destroy
  has_many :menus, through: :menu_beverages
  has_many :order_items

  validates :name, :description, presence: true
end
