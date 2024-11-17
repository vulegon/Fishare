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

ActiveRecord::Schema[7.0].define(version: 2024_10_14_005617) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "audits", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.uuid "auditable_id"
    t.string "auditable_type"
    t.integer "associated_id"
    t.string "associated_type"
    t.integer "user_id"
    t.string "user_type"
    t.string "username"
    t.string "action"
    t.text "audited_changes"
    t.integer "version", default: 0
    t.string "comment"
    t.string "remote_address"
    t.string "request_uuid"
    t.datetime "created_at"
    t.index ["associated_type", "associated_id"], name: "associated_index"
    t.index ["auditable_type", "auditable_id", "version"], name: "auditable_index"
    t.index ["created_at"], name: "index_audits_on_created_at"
    t.index ["request_uuid"], name: "index_audits_on_request_uuid"
    t.index ["user_id", "user_type"], name: "user_index"
  end

  create_table "fish", id: :uuid, default: -> { "gen_random_uuid()" }, comment: "魚のマスタ", force: :cascade do |t|
    t.string "name", null: false, comment: "魚の名前"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["name"], name: "index_fish_on_name_unique", unique: true
  end

  create_table "fishing_spot_fishes", id: :uuid, default: -> { "gen_random_uuid()" }, comment: "釣り場と魚の紐づけを管理する交差テーブル", force: :cascade do |t|
    t.uuid "fishing_spot_id", null: false, comment: "釣り場ID"
    t.uuid "fish_id", null: false, comment: "魚マスタID"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["fish_id"], name: "index_fishing_spot_fishes_on_fish_id"
    t.index ["fishing_spot_id", "fish_id"], name: "index_fishing_spot_fishes_on_fishing_spot_id_and_fish_id_unique", unique: true
    t.index ["fishing_spot_id"], name: "index_fishing_spot_fishes_on_fishing_spot_id"
  end

  create_table "fishing_spot_images", id: :uuid, default: -> { "gen_random_uuid()" }, comment: "釣り場の画像", force: :cascade do |t|
    t.uuid "fishing_spot_id", null: false, comment: "釣り場ID"
    t.string "s3_key", null: false, comment: "S3キー"
    t.string "file_name", null: false, comment: "ファイル名"
    t.string "content_type", null: false, comment: "ファイルの拡張子"
    t.integer "file_size", null: false, comment: "ファイルサイズ"
    t.integer "display_order", null: false, comment: "表示順"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["fishing_spot_id"], name: "index_fishing_spot_images_on_fishing_spot_id"
    t.index ["s3_key"], name: "index_fishing_spot_images_on_s3_key_unique", unique: true
  end

  create_table "fishing_spot_locations", id: :uuid, default: -> { "gen_random_uuid()" }, comment: "釣り場の位置情報", force: :cascade do |t|
    t.uuid "fishing_spot_id", null: false, comment: "釣り場ID"
    t.uuid "prefecture_id", null: false, comment: "都道府県ID"
    t.decimal "latitude", precision: 10, scale: 8, null: false, comment: "緯度"
    t.decimal "longitude", precision: 11, scale: 8, null: false, comment: "経度"
    t.string "address", null: false, comment: "住所"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["fishing_spot_id"], name: "index_fishing_spot_locations_on_fishing_spot_id"
    t.index ["latitude", "longitude"], name: "index_fishing_spot_locations_on_latitude_and_longitude_unique", unique: true
    t.index ["prefecture_id"], name: "index_fishing_spot_locations_on_prefecture_id"
  end

  create_table "fishing_spots", id: :uuid, default: -> { "gen_random_uuid()" }, comment: "釣り場のマスタ", force: :cascade do |t|
    t.string "name", null: false, comment: "釣り場名"
    t.text "description", null: false, comment: "説明"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "prefectures", id: :uuid, default: -> { "gen_random_uuid()" }, comment: "都道府県のマスタ", force: :cascade do |t|
    t.string "name", null: false, comment: "都道府県名"
    t.integer "display_order", null: false, comment: "並び順"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["name"], name: "index_prefectures_on_name_unique", unique: true
  end

  create_table "support_contact_categories", id: :uuid, default: -> { "gen_random_uuid()" }, comment: "お問い合わせの種類マスタ", force: :cascade do |t|
    t.string "name", null: false, comment: "カテゴリ名"
    t.string "description", comment: "カテゴリ説明"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["name"], name: "index_support_contact_categories_on_name_unique", unique: true
  end

  create_table "support_contact_images", id: :uuid, default: -> { "gen_random_uuid()" }, comment: "お問い合わせの画像", force: :cascade do |t|
    t.uuid "support_contact_id", null: false, comment: "お問い合わせID"
    t.string "s3_key", null: false, comment: "S3キー"
    t.string "file_name", null: false, comment: "ファイル名"
    t.string "content_type", null: false, comment: "ファイルの拡張子"
    t.integer "file_size", null: false, comment: "ファイルサイズ"
    t.integer "display_order", null: false, comment: "表示順"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["s3_key"], name: "index_support_contact_images_on_s3_key_unique", unique: true
    t.index ["support_contact_id"], name: "index_support_contact_images_on_support_contact_id"
  end

  create_table "support_contacts", id: :uuid, default: -> { "gen_random_uuid()" }, comment: "お問い合わせ内容", force: :cascade do |t|
    t.string "name", null: false, comment: "お問い合わせ者の名前"
    t.string "email", null: false, comment: "お問い合わせ者のメールアドレス"
    t.text "content", null: false, comment: "お問い合わせ内容"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.uuid "support_contact_category_id", null: false, comment: "お問い合わせカテゴリID"
  end

  create_table "user_roles", id: :uuid, default: -> { "gen_random_uuid()" }, comment: "ユーザーの権限", force: :cascade do |t|
    t.integer "role", null: false, comment: "権限"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["role"], name: "index_user_roles_on_role_unique", unique: true
  end

  create_table "user_roleships", id: :uuid, default: -> { "gen_random_uuid()" }, comment: "ユーザーと権限を管理する交差テーブル", force: :cascade do |t|
    t.uuid "user_id", null: false, comment: "ユーザーID"
    t.uuid "user_role_id", null: false, comment: "ユーザー権限ID"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id", "user_role_id"], name: "index_user_roleships_on_user_id_and_user_role_id_unique", unique: true
    t.index ["user_id"], name: "index_user_roleships_on_user_id"
    t.index ["user_role_id"], name: "index_user_roleships_on_user_role_id"
  end

  create_table "users", id: :uuid, default: -> { "gen_random_uuid()" }, comment: "ユーザー", force: :cascade do |t|
    t.string "name", null: false, comment: "名前"
    t.string "email", null: false, comment: "メールアドレス"
    t.string "provider", default: "email", null: false
    t.string "uid", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.boolean "allow_password_change", default: false
    t.datetime "remember_created_at"
    t.string "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string "unconfirmed_email"
    t.integer "failed_attempts", default: 0, null: false
    t.string "unlock_token"
    t.datetime "locked_at"
    t.integer "sign_in_count", default: 0, null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string "current_sign_in_ip"
    t.string "last_sign_in_ip"
    t.json "tokens"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["confirmation_token"], name: "index_users_on_confirmation_token", unique: true
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
    t.index ["uid", "provider"], name: "index_users_on_uid_and_provider", unique: true
    t.index ["unlock_token"], name: "index_users_on_unlock_token", unique: true
  end

  add_foreign_key "fishing_spot_fishes", "fish"
  add_foreign_key "fishing_spot_fishes", "fishing_spots"
  add_foreign_key "fishing_spot_images", "fishing_spots"
  add_foreign_key "fishing_spot_locations", "fishing_spots"
  add_foreign_key "fishing_spot_locations", "prefectures"
  add_foreign_key "support_contact_images", "support_contacts"
  add_foreign_key "user_roleships", "user_roles"
  add_foreign_key "user_roleships", "users"
end
