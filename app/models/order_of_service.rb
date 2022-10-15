class OrderOfService < ApplicationRecord
  before_validation :generate_order_service_code, on: :create
  before_validation :generate_product_code, on: :create

  has_one :start_service_order
  has_one :carrier, through: :start_service_order
  has_one :transport_model, through: :start_service_order
  has_one :price_by_weight
  has_one :price_per_distance
  has_one :delivery_time

  validates :full_sender_address, :product_code, :product_height, :product_width, :product_length, :recipient_full_address,
            :recipients_name, :order_service_code, :distance, :product_weight, presence: true

  validates :product_height, :product_width, :product_length, :product_weight, :distance,
            numericality: { only_integer: true, greater_than: 0 }

  enum status: { pending: 0, on_route: 5, delivered: 9 }


  private

  def generate_order_service_code
    self.order_service_code = SecureRandom.alphanumeric(15).upcase
  end

  def generate_product_code
    self.product_code = SecureRandom.alphanumeric(5).upcase
  end
end
