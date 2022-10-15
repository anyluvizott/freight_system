class AddProductWeightToOrderOfService < ActiveRecord::Migration[7.0]
  def change
    add_column :order_of_services, :product_weight, :integer
  end
end
