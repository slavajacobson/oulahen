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

ActiveRecord::Schema.define(version: 20150215191051) do

  create_table "amenities", force: true do |t|
    t.integer  "condo_profile_id"
    t.string   "label"
    t.string   "amenity_icon"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "amenities", ["condo_profile_id"], name: "index_amenities_on_condo_profile_id"

  create_table "categories", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "condo_profiles", force: true do |t|
    t.string   "address"
    t.date     "built_on"
    t.integer  "floors"
    t.integer  "units"
    t.string   "corporation"
    t.string   "management"
    t.string   "school_zone"
    t.string   "distance_from_transit"
    t.string   "walk_score"
    t.integer  "total_rented"
    t.integer  "total_owned"
    t.text     "slug"
    t.boolean  "draft",                 default: true
    t.integer  "draft_by"
    t.integer  "priority"
    t.boolean  "active"
    t.integer  "neighbourhood_id"
    t.string   "lon"
    t.string   "lat"
    t.string   "amenities"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "custom_fields", force: true do |t|
    t.string   "field_name"
    t.string   "value"
    t.integer  "team_member_id"
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
    t.integer  "condo_profile_id"
  end

  add_index "floor_plans", ["condo_profile_id"], name: "index_floor_plans_on_condo_profile_id"

  create_table "listings", force: true do |t|
    t.string   "address"
    t.string   "street_number"
    t.boolean  "featured_listing",               default: false
    t.boolean  "show_street_number",             default: true
    t.string   "unit_number"
    t.string   "city_province"
    t.boolean  "show_unit_number",               default: true
    t.string   "postal_code"
    t.string   "neighbourhood"
    t.string   "lot"
    t.integer  "sqft"
    t.string   "bedrooms"
    t.string   "bathrooms"
    t.float    "price"
    t.boolean  "show_price",                     default: true
    t.boolean  "sold"
    t.string   "transaction_label",              default: ""
    t.string   "sold_status"
    t.float    "maintenance_fee"
    t.string   "virtual_tour_url"
    t.text     "map_url",            limit: 255
    t.string   "realtor_url"
    t.string   "facebook_url"
    t.text     "description"
    t.text     "inclusions"
    t.text     "exclusions"
    t.boolean  "active",                         default: true
    t.boolean  "draft",                          default: true
    t.integer  "draft_by"
    t.integer  "priority",                       default: 5
    t.integer  "category_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "slug"
    t.date     "posted_on",                      default: '2015-02-17'
  end

  add_index "listings", ["slug"], name: "index_listings_on_slug"

  create_table "neighbourhoods", force: true do |t|
    t.string   "name"
    t.text     "description"
    t.text     "schools"
    t.integer  "condo_apts"
    t.integer  "detached"
    t.integer  "condo_towns"
    t.integer  "condo_other"
    t.text     "slug"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "photos", force: true do |t|
    t.string   "image"
    t.text     "description"
    t.boolean  "main_photo",       default: false
    t.integer  "listing_id"
    t.integer  "order_priority",   default: 0
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "team_member_id"
    t.integer  "condo_profile_id"
    t.boolean  "featured",         default: false
  end

  add_index "photos", ["condo_profile_id"], name: "index_photos_on_condo_profile_id"
  add_index "photos", ["team_member_id"], name: "index_photos_on_team_member_id"

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
    t.integer  "order",             default: 0
  end

  create_table "team_members", force: true do |t|
    t.string   "name"
    t.string   "title"
    t.text     "bio"
    t.text     "mini_bio"
    t.text     "slug"
    t.boolean  "draft",      default: true
    t.integer  "draft_by"
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
