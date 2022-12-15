class RemoveDeliveryTypeFromStartServiceOrder < ActiveRecord::Migration[7.0]
  def change
    remove_column :start_service_orders, :delivery_type, :string
  end
end
