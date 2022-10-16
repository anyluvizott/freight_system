class AddFinalDateToOrderOfService < ActiveRecord::Migration[7.0]
  def change
    add_column :order_of_services, :final_date, :datetime
  end
end
