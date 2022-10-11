class AddAttributesToOrderOfService < ActiveRecord::Migration[7.0]
  def change
    add_column :order_of_services, :distance, :integer
    add_column :order_of_services, :product_weight, :string
  end
end
