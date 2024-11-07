class MenuBeverage < ApplicationRecord
  belongs_to :menu
  belongs_to :beverage
end
