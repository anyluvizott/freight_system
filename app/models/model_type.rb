class ModelType < ApplicationRecord
  belongs_to :transport_model

  validates :name, :starting_km, :final_km, :deadline, presence: true
  validates :starting_km, :final_km, :deadline, numericality: { only_integer: true, greater_than: 0 }
end
