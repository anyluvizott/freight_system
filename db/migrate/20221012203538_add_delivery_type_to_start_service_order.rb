class AddDeliveryTypeToStartServiceOrder < ActiveRecord::Migration[7.0]
  def change
    add_column :start_service_orders, :delivery_type, :string
  end
end
