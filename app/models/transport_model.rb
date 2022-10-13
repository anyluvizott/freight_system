class TransportModel < ApplicationRecord
  has_many :carriers
  has_many :start_service_orders, through: :carriers

  validates :name, :minimum_distance, :maximum_distance, :minimum_weight, :maximum_weight, :tax, presence: true
  validates :minimum_distance, :maximum_distance, :minimum_weight, :maximum_weight, :tax, numericality: { only_integer: true, greater_than: 0}
end
