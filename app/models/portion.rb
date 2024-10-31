class Portion < ApplicationRecord
  belongs_to :dish, optional: true
  belongs_to :beverage, optional: true
  has_many :price_histories, dependent: :destroy

  validates :description, :price, presence: true
  before_update :record_price_history

  private

  def record_price_history
    price_histories.create(
      description_was: description,
      price_was: price,
      registration_date: self.created_at
    )
  end
end
