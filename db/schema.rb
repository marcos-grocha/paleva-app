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

ActiveRecord::Schema[7.2].define(version: 2024_10_30_195944) do
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

  create_table "beverages", force: :cascade do |t|
    t.string "name"
    t.string "description"
    t.boolean "alcoholic"
    t.integer "calories"
    t.integer "establishment_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "status", default: true
    t.index ["establishment_id"], name: "index_beverages_on_establishment_id"
  end

  create_table "dishes", force: :cascade do |t|
    t.string "name"
    t.string "description"
    t.integer "calories"
    t.integer "establishment_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "status", default: true
    t.boolean "vegetarian", default: false
    t.boolean "vegan", default: false
    t.boolean "gluten_free", default: false
    t.boolean "sugar_free", default: false
    t.boolean "spicy", default: false
    t.index ["establishment_id"], name: "index_dishes_on_establishment_id"
  end

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

  create_table "portions", force: :cascade do |t|
    t.string "description"
    t.decimal "price"
    t.integer "dish_id"
    t.integer "beverage_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["beverage_id"], name: "index_portions_on_beverage_id"
    t.index ["dish_id"], name: "index_portions_on_dish_id"
  end

  create_table "price_histories", force: :cascade do |t|
    t.string "description_was"
    t.string "price_was"
    t.datetime "registration_date"
    t.integer "portion_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["portion_id"], name: "index_price_histories_on_portion_id"
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

  add_foreign_key "active_storage_attachments", "active_storage_blobs", column: "blob_id"
  add_foreign_key "active_storage_variant_records", "active_storage_blobs", column: "blob_id"
  add_foreign_key "beverages", "establishments"
  add_foreign_key "dishes", "establishments"
  add_foreign_key "establishments", "user_owners"
  add_foreign_key "portions", "beverages"
  add_foreign_key "portions", "dishes"
  add_foreign_key "price_histories", "portions"
end
