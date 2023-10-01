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

ActiveRecord::Schema[7.1].define(version: 2023_09_30_232710) do
  create_table "reviews", force: :cascade do |t|
    t.text "feedback"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "user_id", null: false
    t.integer "train_id", null: false
    t.integer "rating"
    t.index ["train_id"], name: "index_reviews_on_train_id"
    t.index ["user_id"], name: "index_reviews_on_user_id"
  end

  create_table "tickets", force: :cascade do |t|
    t.integer "confirmation_number"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "user_id", null: false
    t.integer "train_id", null: false
    t.index ["confirmation_number"], name: "index_tickets_on_confirmation_number", unique: true
    t.index ["train_id"], name: "index_tickets_on_train_id"
    t.index ["user_id"], name: "index_tickets_on_user_id"
  end

  create_table "trains", force: :cascade do |t|
    t.integer "train_number"
    t.string "departure_station"
    t.string "termination_station"
    t.date "departure_date"
    t.time "departure_time"
    t.date "arrival_date"
    t.time "arrival_time"
    t.decimal "ticket_price"
    t.integer "train_capacity"
    t.integer "seats_left"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "ratings"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "name"
    t.string "phone_number"
    t.text "address"
    t.string "credit_card_info"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "reviews", "trains"
  add_foreign_key "reviews", "users"
  add_foreign_key "tickets", "trains"
  add_foreign_key "tickets", "users"
end
