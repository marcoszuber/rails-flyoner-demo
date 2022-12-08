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

ActiveRecord::Schema[7.0].define(version: 2022_12_08_144547) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "active_storage_attachments", force: :cascade do |t|
    t.string "name", null: false
    t.string "record_type", null: false
    t.bigint "record_id", null: false
    t.bigint "blob_id", null: false
    t.datetime "created_at", null: false
    t.index ["blob_id"], name: "index_active_storage_attachments_on_blob_id"
    t.index ["record_type", "record_id", "name", "blob_id"], name: "index_active_storage_attachments_uniqueness", unique: true
  end

  create_table "active_storage_blobs", force: :cascade do |t|
    t.string "key", null: false
    t.string "filename", null: false
    t.string "content_type"
    t.text "metadata"
    t.string "service_name", null: false
    t.bigint "byte_size", null: false
    t.string "checksum"
    t.datetime "created_at", null: false
    t.index ["key"], name: "index_active_storage_blobs_on_key", unique: true
  end

  create_table "active_storage_variant_records", force: :cascade do |t|
    t.bigint "blob_id", null: false
    t.string "variation_digest", null: false
    t.index ["blob_id", "variation_digest"], name: "index_active_storage_variant_records_uniqueness", unique: true
  end

  create_table "aircrafts", force: :cascade do |t|
    t.string "name"
    t.integer "price"
    t.integer "seats"
    t.text "description"
    t.bigint "user_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "status"
    t.index ["user_id"], name: "index_aircrafts_on_user_id"
  end

  create_table "airports", force: :cascade do |t|
    t.string "name"
    t.float "lat"
    t.float "lon"
    t.string "layer"
    t.integer "quantity"
    t.string "continent"
    t.string "country"
    t.string "region"
    t.string "code"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "bookings", force: :cascade do |t|
    t.datetime "start_time"
    t.datetime "finish_time"
    t.bigint "user_id", null: false
    t.bigint "aircraft_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "from"
    t.string "to"
    t.bigint "empty_leg_id"
    t.bigint "review_aircraft_id"
    t.bigint "payment_id"
    t.integer "total_price", default: 0
    t.index ["aircraft_id"], name: "index_bookings_on_aircraft_id"
    t.index ["empty_leg_id"], name: "index_bookings_on_empty_leg_id"
    t.index ["payment_id"], name: "index_bookings_on_payment_id"
    t.index ["review_aircraft_id"], name: "index_bookings_on_review_aircraft_id"
    t.index ["user_id"], name: "index_bookings_on_user_id"
  end

  create_table "empty_legs", force: :cascade do |t|
    t.string "from"
    t.string "to"
    t.datetime "date"
    t.integer "seat_available"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "feedbacks", force: :cascade do |t|
    t.string "description"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "payments", force: :cascade do |t|
    t.string "status"
    t.string "status_detail"
    t.integer "merchant_order_id"
    t.string "processing_mode"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "review_aircrafts", force: :cascade do |t|
    t.float "stars"
    t.text "description"
    t.bigint "aircraft_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "user_id"
    t.index ["aircraft_id"], name: "index_review_aircrafts_on_aircraft_id"
    t.index ["user_id"], name: "index_review_aircrafts_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "first_name"
    t.string "last_name"
    t.string "dni"
    t.boolean "owner"
    t.boolean "client"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "active_storage_attachments", "active_storage_blobs", column: "blob_id"
  add_foreign_key "active_storage_variant_records", "active_storage_blobs", column: "blob_id"
  add_foreign_key "aircrafts", "users"
  add_foreign_key "bookings", "aircrafts"
  add_foreign_key "bookings", "empty_legs"
  add_foreign_key "bookings", "payments"
  add_foreign_key "bookings", "review_aircrafts"
  add_foreign_key "bookings", "users"
  add_foreign_key "review_aircrafts", "aircrafts"
end
