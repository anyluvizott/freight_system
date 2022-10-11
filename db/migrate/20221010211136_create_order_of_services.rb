class CreateOrderOfServices < ActiveRecord::Migration[7.0]
  def change
    create_table :order_of_services do |t|
      t.string :full_sender_address
      t.string :product_code
      t.integer :product_height
      t.integer :product_width
      t.integer :product_length
      t.string :recipient_full_address
      t.string :recipients_name

      t.timestamps
    end
  end
end
