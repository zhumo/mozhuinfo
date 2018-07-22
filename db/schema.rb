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

ActiveRecord::Schema.define(version: 20180722191156) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "blogs", id: :serial, force: :cascade do |t|
    t.string "title", limit: 256, null: false
    t.text "body", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.datetime "published_at"
    t.string "summary", limit: 256, null: false
    t.string "slug", limit: 128, null: false
    t.index ["slug"], name: "index_blogs_on_slug", unique: true
  end

  create_table "programmatic_messages", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.string "algorithm", limit: 128, null: false
    t.string "body", limit: 128, null: false
    t.datetime "next_message_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_programmatic_messages_on_user_id"
  end

  create_table "sessions", id: :serial, force: :cascade do |t|
    t.string "token", limit: 128, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", force: :cascade do |t|
    t.string "name", limit: 128, null: false
    t.string "phone_number", limit: 128, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["name"], name: "index_users_on_name", unique: true
    t.index ["phone_number"], name: "index_users_on_phone_number", unique: true
  end

end
