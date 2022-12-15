class StartServiceOrder < ApplicationRecord
  belongs_to :order_of_service
  has_one :carrier
  has_one :transport_model, through: :carrier
  has_one :model_type

  validates :model_type_id, :carrier_id, presence: true
end