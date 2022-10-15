class DeliveryTime < ApplicationRecord
  has_one :order_of_service

  validates :starting_km, :final_km, :deadline, presence: true
  validates :starting_km, :final_km, :deadline, numericality: { only_integer: true, greater_than: 0 }
  
end