# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.


ActiveRecord::Schema.define(version: 20180321155611) do


  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "accommodations", force: :cascade do |t|
    t.date "start_date"
    t.date "end_date"
    t.string "status"
    t.string "reference_number"
    t.integer "number_of_nights"
    t.bigint "participation_id"
    t.string "address"
    t.string "name"
    t.string "photo"
    t.string "phone_number"
    t.string "url"
    t.string "email"
    t.float "total_price"
    t.integer "number_of_rooms"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.float "latitude"
    t.float "longitude"
    t.bigint "trip_id"
    t.index ["participation_id"], name: "index_accommodations_on_participation_id"
    t.index ["trip_id"], name: "index_accommodations_on_trip_id"
  end

  create_table "activities", force: :cascade do |t|
    t.date "date"
    t.time "start_time"
    t.string "status"
    t.bigint "participation_id"
    t.string "address"
    t.string "name"
    t.string "photo"
    t.string "phone_number"
    t.text "description"
    t.string "url"
    t.string "email"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.float "latitude"
    t.float "longitude"
    t.bigint "trip_id"
    t.index ["participation_id"], name: "index_activities_on_participation_id"
    t.index ["trip_id"], name: "index_activities_on_trip_id"
  end

  create_table "participations", force: :cascade do |t|
    t.bigint "user_id"
    t.bigint "trip_id"
    t.string "token"
    t.string "pseudo"
    t.string "email"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "avatar"
    t.index ["trip_id"], name: "index_participations_on_trip_id"
    t.index ["user_id"], name: "index_participations_on_user_id"
  end

  create_table "restaurants", force: :cascade do |t|
    t.time "start_time"
    t.date "date"
    t.string "status"
    t.bigint "participation_id"
    t.string "address"
    t.string "name"
    t.string "photo"
    t.string "phone_number"
    t.text "description"
    t.string "url"
    t.string "email"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.float "latitude"
    t.float "longitude"
    t.bigint "trip_id"
    t.index ["participation_id"], name: "index_restaurants_on_participation_id"
    t.index ["trip_id"], name: "index_restaurants_on_trip_id"
  end

  create_table "transportations", force: :cascade do |t|
    t.bigint "participation_id"
    t.string "type"
    t.string "departure_port"
    t.string "arrival_port"
    t.string "reference_number"
    t.string "status"
    t.float "price_per_person"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.float "departure_port_latitude"
    t.float "departure_port_longitude"
    t.float "arrival_port_latitude"
    t.float "arrival_port_longitude"
    t.datetime "departure_date"
    t.datetime "arrival_date"
    t.index ["participation_id"], name: "index_transportations_on_participation_id"
  end

  create_table "trips", force: :cascade do |t|
    t.string "name"
    t.string "destination"
    t.string "photo"
    t.date "start_date"
    t.date "end_date"
    t.text "description"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer "sign_in_count", default: 0, null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet "current_sign_in_ip"
    t.inet "last_sign_in_ip"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "first_name"
    t.string "last_name"
    t.string "avatar"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "accommodations", "participations"
  add_foreign_key "activities", "participations"
  add_foreign_key "participations", "trips"
  add_foreign_key "participations", "users"
  add_foreign_key "restaurants", "participations"
  add_foreign_key "transportations", "participations"
end
