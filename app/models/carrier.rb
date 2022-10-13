class Carrier < ApplicationRecord
  belongs_to :transport_model
  has_one :start_service_order

  validates :drivers_name, :vehicle_model, :vehicle_brand, :maximum_weight, :year_of_manufacture, presence: true
  validates :year_of_manufacture, :maximum_weight, numericality: { only_integer: true, greater_than: 0 }
  validates :year_of_manufacture, length: { is: 4 }

  enum status: { active: 0, on_delivery: 5, under_maintenance: 9 }


  def description_carrier
    "#{transport_model.name} - #{vehicle_model}"
  end

end