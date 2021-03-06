# encoding: UTF-8
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

ActiveRecord::Schema.define(version: 20150701183308) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "amenities", force: :cascade do |t|
    t.string   "perk"
    t.integer  "room_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "amenities", ["room_id"], name: "index_amenities_on_room_id", using: :btree

  create_table "companies", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
    t.string   "logo"
    t.string   "primary_color"
    t.string   "secondary_color"
  end

  create_table "employee_meetings", force: :cascade do |t|
    t.integer  "enrolled",    default: 0
    t.integer  "employee_id"
    t.integer  "meeting_id"
    t.datetime "created_at",              null: false
    t.datetime "updated_at",              null: false
  end

  create_table "employees", force: :cascade do |t|
    t.string   "email",                  default: "",    null: false
    t.string   "encrypted_password",     default: "",    null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,     null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet     "current_sign_in_ip"
    t.inet     "last_sign_in_ip"
    t.string   "name"
    t.boolean  "admin",                  default: false
    t.datetime "created_at",                             null: false
    t.datetime "updated_at",                             null: false
    t.integer  "company_id"
  end

  add_index "employees", ["email"], name: "index_employees_on_email", unique: true, using: :btree
  add_index "employees", ["reset_password_token"], name: "index_employees_on_reset_password_token", unique: true, using: :btree

  create_table "invitations", force: :cascade do |t|
    t.integer  "employee_id"
    t.integer  "meeting_id"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  create_table "meetings", force: :cascade do |t|
    t.string   "title",                       null: false
    t.text     "agenda",                      null: false
    t.datetime "start_time",                  null: false
    t.datetime "end_time",                    null: false
    t.boolean  "private",     default: false
    t.integer  "room_id"
    t.integer  "employee_id"
    t.datetime "created_at",                  null: false
    t.datetime "updated_at",                  null: false
  end

  create_table "room_amenities", force: :cascade do |t|
    t.integer  "room_id"
    t.integer  "amenity_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "room_amenities", ["amenity_id"], name: "index_room_amenities_on_amenity_id", using: :btree
  add_index "room_amenities", ["room_id"], name: "index_room_amenities_on_room_id", using: :btree

  create_table "rooms", force: :cascade do |t|
    t.string   "name"
    t.integer  "max_occupancy"
    t.integer  "room_number"
    t.string   "imgurl"
    t.string   "location",                   null: false
    t.integer  "company_id"
    t.integer  "meetings_count", default: 0
    t.datetime "created_at",                 null: false
    t.datetime "updated_at",                 null: false
  end

  add_foreign_key "amenities", "rooms"
  add_foreign_key "room_amenities", "amenities"
  add_foreign_key "room_amenities", "rooms"
end
