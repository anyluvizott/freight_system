class RemoveProductWeightFromOrderOfService < ActiveRecord::Migration[7.0]
  def change
    remove_column :order_of_services, :product_weight, :string
  end
end
