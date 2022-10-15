class StartServiceOrder < ApplicationRecord
  belongs_to :order_of_service
  has_one :carrier
  has_one :transport_model, through: :carrier

  validates :delivery_type, presence: true
end