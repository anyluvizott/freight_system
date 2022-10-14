class CreateDeliveryTimes < ActiveRecord::Migration[7.0]
  def change
    create_table :delivery_times do |t|
      t.integer :starting_km
      t.integer :final_km
      t.time :deadline

      t.timestamps
    end
  end
end
