class AddCarrierToStartServiceOrder < ActiveRecord::Migration[7.0]
  def change
    add_reference :start_service_orders, :carrier, null: false, foreign_key: true
  end
end
