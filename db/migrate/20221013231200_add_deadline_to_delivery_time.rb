class AddDeadlineToDeliveryTime < ActiveRecord::Migration[7.0]
  def change
    add_column :delivery_times, :deadline, :integer
  end
end
