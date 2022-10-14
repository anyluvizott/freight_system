# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[7.0].define(version: 2022_10_13_231200) do
  create_table "carriers", force: :cascade do |t|
    t.string "drivers_name"
    t.string "nameplate"
    t.string "vehicle_model"
    t.string "vehicle_brand"
    t.integer "year_of_manufacture"
    t.integer "maximum_weight"
    t.integer "transport_model_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "status", default: 0
    t.index ["transport_model_id"], name: "index_carriers_on_transport_model_id"
  end

  create_table "delivery_times", force: :cascade do |t|
    t.integer "starting_km"
    t.integer "final_km"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "deadline"
  end

  create_table "order_of_services", force: :cascade do |t|
    t.string "full_sender_address"
    t.string "product_code"
    t.integer "product_height"
    t.integer "product_width"
    t.integer "product_length"
    t.string "recipient_full_address"
    t.string "recipients_name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "status", default: 0
    t.string "order_service_code"
    t.integer "distance"
    t.string "product_weight"
    t.date "delivery_date"
  end

  create_table "price_by_weights", force: :cascade do |t|
    t.integer "starting_weight"
    t.integer "final_weight"
    t.decimal "price_per_km"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "price_per_distances", force: :cascade do |t|
    t.integer "starting_km"
    t.integer "final_km"
    t.decimal "fixed_price"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "start_service_orders", force: :cascade do |t|
    t.integer "order_of_service_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "carrier_id", null: false
    t.string "delivery_type"
    t.index ["carrier_id"], name: "index_start_service_orders_on_carrier_id"
    t.index ["order_of_service_id"], name: "index_start_service_orders_on_order_of_service_id"
  end

  create_table "transport_models", force: :cascade do |t|
    t.string "name"
    t.integer "minimum_distance"
    t.integer "maximum_distance"
    t.integer "minimum_weight"
    t.integer "maximum_weight"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "tax"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "status", default: 0
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "carriers", "transport_models"
  add_foreign_key "start_service_orders", "carriers"
  add_foreign_key "start_service_orders", "order_of_services"
end
