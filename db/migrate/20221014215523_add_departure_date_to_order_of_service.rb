class AddDepartureDateToOrderOfService < ActiveRecord::Migration[7.0]
  def change
    add_column :order_of_services, :departure_date, :date
  end
end
