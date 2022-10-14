class RemoveDeadlineFromDeliveryTime < ActiveRecord::Migration[7.0]
  def change
    remove_column :delivery_times, :deadline, :time
  end
end
