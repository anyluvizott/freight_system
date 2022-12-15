class AddPriceToModelType < ActiveRecord::Migration[7.0]
  def change
    add_column :model_types, :price, :decimal
  end
end
