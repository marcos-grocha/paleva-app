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

ActiveRecord::Schema[7.2].define(version: 2024_10_25_025959) do
  create_table "establishments", force: :cascade do |t|
    t.string "fantasy_name"
    t.string "corporate_name"
    t.string "cnpj"
    t.string "address"
    t.integer "telephone"
    t.string "email"
    t.string "code"
    t.integer "user_owner_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "sunday"
    t.boolean "monday"
    t.boolean "tuesday"
    t.boolean "wednesday"
    t.boolean "thursday"
    t.boolean "friday"
    t.boolean "saturday"
    t.time "opening_time"
    t.time "closing_time"
    t.index ["user_owner_id"], name: "index_establishments_on_user_owner_id"
  end

  create_table "user_owners", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.string "name"
    t.string "last_name"
    t.string "cpf"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_user_owners_on_email", unique: true
    t.index ["reset_password_token"], name: "index_user_owners_on_reset_password_token", unique: true
  end

  add_foreign_key "establishments", "user_owners"
end
