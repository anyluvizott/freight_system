class PriceByWeight < ApplicationRecord
  has_one :order_of_service

  validates :starting_weight, :final_weight, :price_per_km, presence: true
  validates :starting_weight, :final_weight, numericality: { only_integer: true, greater_than: 0 }
  validates :price_per_km, numericality: { greater_than: 0 }
end
