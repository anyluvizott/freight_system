class AddStatusToOrderOfService < ActiveRecord::Migration[7.0]
  def change
    add_column :order_of_services, :status, :integer, default: 0
  end
end
