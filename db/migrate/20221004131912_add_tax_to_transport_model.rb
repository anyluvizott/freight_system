class AddTaxToTransportModel < ActiveRecord::Migration[7.0]
  def change
    add_column :transport_models, :tax, :integer
  end
end
