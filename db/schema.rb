# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `rails
# db:schema:load`. When creating a new database, `rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2020_07_05_153753) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "advertisers", force: :cascade do |t|
    t.string "name", null: false
    t.string "url", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "offers", force: :cascade do |t|
    t.bigint "advertiser_id", null: false
    t.string "url", null: false
    t.string "description", limit: 500, null: false
    t.datetime "starts_at", null: false
    t.datetime "ends_at"
    t.boolean "premium", default: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["advertiser_id"], name: "index_offers_on_advertiser_id"
    t.index ["ends_at"], name: "index_offers_on_ends_at"
    t.index ["premium"], name: "index_offers_on_premium"
    t.index ["starts_at"], name: "index_offers_on_starts_at"
  end

  add_foreign_key "offers", "advertisers"
end
