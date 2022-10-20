class PriceByWeight < ApplicationRecord
  has_one :order_of_service

  validates :starting_weight, :final_weight, :price_per_km, presence: true
  validates :starting_weight, :final_weight, numericality: { only_integer: true, greater_than: 0 }
  validates :price_per_km, numericality: { greater_than: 0 }
  validate :starting_value

  private

  def starting_value
    if !starting_weight.nil? && !final_weight.nil? && (starting_weight > final_weight)
      errors.add(:starting_weight, 'deve ser menor que o peso final')
    end
  end
end
