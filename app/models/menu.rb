class Menu < ApplicationRecord
  belongs_to :establishment
  has_many :menu_dishes, dependent: :destroy
  has_many :dishes, through: :menu_dishes
  has_many :menu_beverages, dependent: :destroy
  has_many :beverages, through: :menu_beverages
  has_many :order_items

  validates :name, presence: true, uniqueness: { scope: :establishment_id, message: "Já existe um cardápio com esse nome" }
  scope :active, -> { where(status: true) }
end
