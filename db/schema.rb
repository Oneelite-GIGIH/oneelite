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

ActiveRecord::Schema[7.0].define(version: 2022_06_21_204624) do
  create_table "delivery_couriers", force: :cascade do |t|
    t.integer "user_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_delivery_couriers_on_user_id"
  end

  create_table "transactions", force: :cascade do |t|
    t.integer "user_id", null: false
    t.integer "delivery_courier_id"
    t.integer "waste_id", null: false
    t.decimal "nominal_dibayar", default: "0.0"
    t.integer "status", default: 0
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["delivery_courier_id"], name: "index_transactions_on_delivery_courier_id"
    t.index ["user_id"], name: "index_transactions_on_user_id"
    t.index ["waste_id"], name: "index_transactions_on_waste_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "nama"
    t.string "no_hp"
    t.string "email"
    t.integer "role", default: 0
    t.decimal "saldo"
    t.text "alamat"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "wastes", force: :cascade do |t|
    t.integer "user_id", null: false
    t.string "jenis_sampah"
    t.float "berat"
    t.text "gambar"
    t.text "alamat_penjemputan"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_wastes_on_user_id"
  end

  add_foreign_key "delivery_couriers", "users"
  add_foreign_key "transactions", "delivery_couriers"
  add_foreign_key "transactions", "users"
  add_foreign_key "transactions", "wastes"
  add_foreign_key "wastes", "users"
end
