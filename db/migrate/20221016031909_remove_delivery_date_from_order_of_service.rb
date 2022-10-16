class RemoveDeliveryDateFromOrderOfService < ActiveRecord::Migration[7.0]
  def change
    remove_column :order_of_services, :delivery_date, :date
  end
end
