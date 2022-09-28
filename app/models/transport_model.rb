class TransportModel < ApplicationRecord
  validates :name, :minimum_distance, :maximum_distance, :minimum_weight, :maximum_weight, presence: true
  validates :minimum_distance, :maximum_distance, :minimum_weight, :maximum_weight, numericality: { only_integer: true, greater_than: 0}
end
