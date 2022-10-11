class PriceByWeight < ApplicationRecord
  validates :starting_weight, :final_weight, :price_per_km, presence: true
end
