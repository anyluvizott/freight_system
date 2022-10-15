class PricePerDistance < ApplicationRecord
  has_one :order_of_service

  validates :starting_km, :final_km, :fixed_price, presence: true
  validates :starting_km, :final_km, numericality: { only_integer: true, greater_than: 0 }
  validates :fixed_price, numericality: { greater_than: 0 }

end
