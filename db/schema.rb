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

ActiveRecord::Schema.define(version: 2018_07_03_145705) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "annexeds", force: :cascade do |t|
    t.bigint "examination_id"
    t.datetime "date"
    t.string "title"
    t.string "description"
    t.string "city"
    t.string "address"
    t.datetime "start_hour"
    t.datetime "end_hour"
    t.float "current_weight"
    t.float "current_chest"
    t.float "current_umbilical"
    t.float "current_shoulder"
    t.float "current_olecranon"
    t.float "current_height"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "image"
    t.index ["examination_id"], name: "index_annexeds_on_examination_id"
  end

  create_table "audits", force: :cascade do |t|
    t.bigint "horse_id"
    t.bigint "vet_id"
    t.datetime "end_date"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["horse_id"], name: "index_audits_on_horse_id"
    t.index ["vet_id"], name: "index_audits_on_vet_id"
  end

  create_table "clients", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "examinations", force: :cascade do |t|
    t.bigint "audit_id"
    t.string "title"
    t.string "description"
    t.string "city"
    t.string "address"
    t.datetime "start_hour"
    t.datetime "end_hour"
    t.float "current_weight"
    t.float "current_chest"
    t.float "current_umbilical"
    t.float "current_shoulder"
    t.float "current_olecranon"
    t.float "current_height"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["audit_id"], name: "index_examinations_on_audit_id"
  end

  create_table "horses", force: :cascade do |t|
    t.string "name"
    t.string "breed"
    t.string "gender"
    t.string "color"
    t.datetime "born_date"
    t.float "current_weight"
    t.float "current_chest"
    t.float "current_umbilical"
    t.float "current_shoulder"
    t.float "current_olecranon"
    t.float "current_height"
    t.float "born_weight"
    t.float "born_chest"
    t.float "born_umbilical"
    t.float "born_shoulder"
    t.float "born_olecranon"
    t.float "born_height"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "jwt_blacklists", force: :cascade do |t|
    t.string "jti", null: false
    t.datetime "exp", null: false
    t.index ["jti"], name: "index_jwt_blacklists_on_jti"
  end

  create_table "owners", force: :cascade do |t|
    t.bigint "horse_id"
    t.bigint "client_id"
    t.datetime "end_date"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["client_id"], name: "index_owners_on_client_id"
    t.index ["horse_id"], name: "index_owners_on_horse_id"
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
    t.string "authentication_token", limit: 30
    t.string "name"
    t.string "lastname"
    t.string "type"
    t.index ["authentication_token"], name: "index_users_on_authentication_token", unique: true
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  create_table "vets", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

end
