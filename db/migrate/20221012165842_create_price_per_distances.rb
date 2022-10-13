class CreatePricePerDistances < ActiveRecord::Migration[7.0]
  def change
    create_table :price_per_distances do |t|
      t.integer :starting_km
      t.integer :final_km
      t.decimal :fixed_price

      t.timestamps
    end
  end
end
