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

ActiveRecord::Schema.define(version: 20130810192137) do

  create_table "categories", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "feature_sheets", force: true do |t|
    t.string   "file"
    t.text     "description"
    t.integer  "listing_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "floor_plans", force: true do |t|
    t.string   "file"
    t.text     "description"
    t.integer  "listing_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "listings", force: true do |t|
    t.string   "address"
    t.string   "street_number"
    t.boolean  "featured_listing",   default: false
    t.boolean  "show_street_number", default: true
    t.string   "unit_number"
    t.string   "city_province"
    t.boolean  "show_unit_number",   default: true
    t.string   "postal_code"
    t.string   "neighbourhood"
    t.integer  "lot_frontage"
    t.integer  "lot_depth"
    t.integer  "sqft"
    t.integer  "bedrooms"
    t.integer  "bathrooms"
    t.float    "price"
    t.float    "sold_price"
    t.boolean  "show_sold_price",    default: false
    t.boolean  "sold"
    t.string   "transaction_label",  default: ""
    t.string   "sold_status"
    t.float    "maintenance_fee"
    t.string   "virtual_tour_url"
    t.string   "map_url"
    t.string   "realtor_url"
    t.string   "facebook_url"
    t.text     "description"
    t.text     "inclusions"
    t.text     "exclusions"
    t.boolean  "active",             default: true
    t.boolean  "draft",              default: true
    t.integer  "draft_by"
    t.integer  "category_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "slug"
  end

  add_index "listings", ["slug"], name: "index_listings_on_slug"

  create_table "photos", force: true do |t|
    t.string   "image"
    t.text     "description"
    t.boolean  "main_photo",  default: false
    t.integer  "listing_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "slide_show_images", force: true do |t|
    t.string   "image"
    t.string   "video"
    t.string   "description_line1"
    t.string   "description_line2"
    t.string   "link_to"
    t.boolean  "active",            default: true
    t.boolean  "is_video",          default: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", force: true do |t|
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true

end
