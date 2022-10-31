class AddStatusToModelType < ActiveRecord::Migration[7.0]
  def change
    add_column :model_types, :status, :integer, default: 0
  end
end
