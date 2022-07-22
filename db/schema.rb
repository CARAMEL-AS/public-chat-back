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

ActiveRecord::Schema.define(version: 2022_07_19_185512) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "accverifies", force: :cascade do |t|
    t.integer "user_id"
    t.string "code"
    t.boolean "verified"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "appwarnings", force: :cascade do |t|
    t.integer "user_id"
    t.integer "count", default: 0
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "groups", force: :cascade do |t|
    t.integer "admin"
    t.integer "member"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "messages", force: :cascade do |t|
    t.integer "user_id"
    t.string "message"
    t.integer "group_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "settings", force: :cascade do |t|
    t.integer "user_id"
    t.string "theme", default: "LIGHT"
    t.string "language", default: "ENGLISH"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "socialauths", force: :cascade do |t|
    t.string "email"
    t.string "username"
    t.string "image"
    t.boolean "online", default: true
    t.boolean "status", default: true
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "users", force: :cascade do |t|
    t.string "email"
    t.string "password_digest"
    t.string "image", default: ""
    t.boolean "online", default: true
    t.string "username", default: "Bess Twishes"
    t.boolean "status", default: true
  end

end
