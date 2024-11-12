class OrderItem < ApplicationRecord
  belongs_to :order
  belongs_to :dish, optional: true
  belongs_to :beverage, optional: true
  belongs_to :portion

  validates :quantity, numericality: { greater_than: 0 }
end
