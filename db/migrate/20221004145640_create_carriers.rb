class CreateCarriers < ActiveRecord::Migration[7.0]
  def change
    create_table :carriers do |t|
      t.string :drivers_name
      t.string :nameplate
      t.string :vehicle_model
      t.string :vehicle_brand
      t.integer :year_of_manufacture
      t.integer :maximum_weight
      t.references :transport_model, null: false, foreign_key: true

      t.timestamps
    end
  end
end
