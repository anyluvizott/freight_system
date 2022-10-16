class AddDeliveryDateToOrderOfService < ActiveRecord::Migration[7.0]
  def change
    add_column :order_of_services, :delivery_date, :datetime
  end
end
