class CreateModelTypes < ActiveRecord::Migration[7.0]
  def change
    create_table :model_types do |t|
      t.string :name
      t.integer :starting_km
      t.integer :final_km
      t.integer :deadline
      t.references :transport_model, null: false, foreign_key: true

      t.timestamps
    end
  end
end
