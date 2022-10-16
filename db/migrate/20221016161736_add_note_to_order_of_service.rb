class AddNoteToOrderOfService < ActiveRecord::Migration[7.0]
  def change
    add_column :order_of_services, :note, :string
  end
end
