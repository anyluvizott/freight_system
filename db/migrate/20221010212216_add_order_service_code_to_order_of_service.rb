class AddOrderServiceCodeToOrderOfService < ActiveRecord::Migration[7.0]
  def change
    add_column :order_of_services, :order_service_code, :string
  end
end
