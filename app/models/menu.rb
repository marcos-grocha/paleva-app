class Menu < ApplicationRecord
  belongs_to :user_owner
  has_many :menu_dishes, dependent: :destroy
  has_many :dishes, through: :menu_dishes
  has_many :menu_beverages, dependent: :destroy
  has_many :beverages, through: :menu_beverages
  has_many :order_items

  validates :name, presence: true, uniqueness: { scope: :user_owner_id, message: "Já existe um cardápio com esse nome" }
end
