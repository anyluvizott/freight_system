class ModelType < ApplicationRecord
  belongs_to :transport_model

  validates :name, :starting_km, :final_km, :deadline, presence: true
  validates :starting_km, :final_km, :deadline, numericality: { only_integer: true, greater_than: 0 }

  enum status: { active: 0, inactive: 2 }

  validate :starting_value

  private

  def starting_value
    if !starting_km.nil? && !final_km.nil? && (starting_km > final_km)
      errors.add(:starting_km, 'deve ser menor que o Km Final')
    end
  end

  def initial_limit
    @transport_model = TransportModel.find(@model_type.transport_model_id)
    starting_km < @transport_model.minimum_distance
    errors.add(:starting_km, 'deve estar dentro da Modalidade de Transporte')
  end
end
