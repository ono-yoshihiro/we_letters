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

ActiveRecord::Schema.define(version: 2022_11_09_110330) do

  create_table "addresses", force: :cascade do |t|
    t.string "address", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "admins", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["email"], name: "index_admins_on_email", unique: true
    t.index ["reset_password_token"], name: "index_admins_on_reset_password_token", unique: true
  end

  create_table "barcodes", force: :cascade do |t|
    t.string "barcode", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "budgets", force: :cascade do |t|
    t.string "name", null: false
    t.boolean "is_deleted", default: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "delivery_date_options", force: :cascade do |t|
    t.string "option", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "letter_details", force: :cascade do |t|
    t.integer "send_letter_id", null: false
    t.integer "type_id", null: false
    t.integer "applicable_price"
    t.integer "number", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "letters", force: :cascade do |t|
    t.integer "section_id", null: false
    t.integer "type_id", null: false
    t.integer "number", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "payment_budgets", force: :cascade do |t|
    t.integer "section_id", null: false
    t.integer "budget_id", null: false
    t.boolean "is_deleted", default: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "personal_receipt_options", force: :cascade do |t|
    t.string "option", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "post_offices", force: :cascade do |t|
    t.string "name", null: false
    t.string "postal_code", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "proof_contents_options", force: :cascade do |t|
    t.string "option", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "proof_delivery_options", force: :cascade do |t|
    t.string "option", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "registered_options", force: :cascade do |t|
    t.string "option", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "sections", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.string "name", null: false
    t.string "pic_name", null: false
    t.string "telephone_number", null: false
    t.boolean "status", default: false, null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["email"], name: "index_sections_on_email", unique: true
    t.index ["reset_password_token"], name: "index_sections_on_reset_password_token", unique: true
  end

  create_table "send_letters", force: :cascade do |t|
    t.integer "section_id", null: false
    t.integer "payment_budget_id", null: false
    t.boolean "status", default: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "sizes", force: :cascade do |t|
    t.string "size", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "type_names", force: :cascade do |t|
    t.string "type_name", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "types", force: :cascade do |t|
    t.integer "type_name_id", null: false
    t.integer "weight_id", null: false
    t.integer "size_id", null: false
    t.integer "address_id", null: false
    t.integer "barcode_id", null: false
    t.integer "price", null: false
    t.integer "special_price_1", null: false
    t.integer "special_price_2", null: false
    t.integer "special_price_3", null: false
    t.integer "delivery_date_option_id", null: false
    t.integer "delivery_date_option_price", null: false
    t.integer "registered_option_id", null: false
    t.integer "registered_option_price", null: false
    t.integer "proof_delivery_option_id", null: false
    t.integer "proof_delivery_option_price", null: false
    t.integer "proof_contents_option_id", null: false
    t.integer "proof_contents_option_price", null: false
    t.integer "personal_receipt_option_id", null: false
    t.integer "personal_receipt_option_price", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "weights", force: :cascade do |t|
    t.string "weight"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

end
