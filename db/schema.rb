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

ActiveRecord::Schema.define(version: 2022_07_09_203047) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "appwarnings", force: :cascade do |t|
    t.integer "user_id"
    t.integer "count"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "groups", force: :cascade do |t|
    t.integer "user_id"
    t.string "group_name"
    t.string "group_code"
    t.integer "member_ids", default: [], array: true
    t.string "messages", default: [], array: true
    t.string "banned_member_ids", default: [], array: true
  end

  create_table "messages", force: :cascade do |t|
    t.integer "user_id"
    t.integer "group_id"
    t.string "message"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "users", force: :cascade do |t|
    t.string "email"
    t.string "password_digest"
    t.boolean "online", default: true
    t.string "username", default: "Ben Lyon"
    t.boolean "status", default: true
  end

end