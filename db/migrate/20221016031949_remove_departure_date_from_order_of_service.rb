class RemoveDepartureDateFromOrderOfService < ActiveRecord::Migration[7.0]
  def change
    remove_column :order_of_services, :departure_date, :date
  end
end
