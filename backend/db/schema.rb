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

ActiveRecord::Schema[7.0].define(version: 2024_09_25_214317) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "contacts", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "name", null: false
    t.string "email", null: false
    t.string "content", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "fish", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "name", null: false, comment: "魚の名前"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "fishing_spot_fishes", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.uuid "fishing_spot_id", null: false
    t.uuid "fish_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["fish_id"], name: "index_fishing_spot_fishes_on_fish_id"
    t.index ["fishing_spot_id"], name: "index_fishing_spot_fishes_on_fishing_spot_id"
  end

  create_table "fishing_spot_locations", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.uuid "fishing_spot_id", null: false, comment: "釣り場ID"
    t.uuid "prefecture_id", null: false, comment: "都道府県ID"
    t.decimal "latitude", precision: 10, scale: 8, null: false, comment: "緯度"
    t.decimal "longitude", precision: 11, scale: 8, null: false, comment: "経度"
    t.string "address", null: false, comment: "住所"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["fishing_spot_id"], name: "index_fishing_spot_locations_on_fishing_spot_id"
    t.index ["prefecture_id"], name: "index_fishing_spot_locations_on_prefecture_id"
  end

  create_table "fishing_spots", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "name", null: false
    t.text "description"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "prefectures", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "name", null: false, comment: "都道府県名"
    t.integer "sort", null: false, comment: "並び順"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_foreign_key "fishing_spot_fishes", "fish"
  add_foreign_key "fishing_spot_fishes", "fishing_spots"
  add_foreign_key "fishing_spot_locations", "fishing_spots"
  add_foreign_key "fishing_spot_locations", "prefectures"
end
