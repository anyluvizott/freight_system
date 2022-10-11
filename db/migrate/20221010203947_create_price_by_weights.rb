class CreatePriceByWeights < ActiveRecord::Migration[7.0]
  def change
    create_table :price_by_weights do |t|
      t.integer :starting_weight
      t.integer :final_weight
      t.decimal :price_per_km

      t.timestamps
    end
  end
end
