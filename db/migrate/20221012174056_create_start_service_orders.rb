class CreateStartServiceOrders < ActiveRecord::Migration[7.0]
  def change
    create_table :start_service_orders do |t|
      t.references :order_of_service, null: false, foreign_key: true

      t.timestamps
    end
  end
end
