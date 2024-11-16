class OrderItem < ApplicationRecord
  belongs_to :order
  belongs_to :portion
  belongs_to :dish, optional: true
  belongs_to :beverage, optional: true

  validates :quantity, numericality: { greater_than: 0 }
end
