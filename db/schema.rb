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

ActiveRecord::Schema.define(version: 20180207033716) do

  create_table "comments", force: :cascade do |t|
    t.integer "item_id"
    t.string "comment_body"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "reply"
    t.string "judge"
  end

  create_table "departments", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "genres", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "items", force: :cascade do |t|
    t.string "name"
    t.string "image"
    t.integer "price"
    t.string "detail"
    t.integer "student_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "department_id"
    t.integer "place_id"
    t.integer "genre_id"
    t.string "pass"
    t.integer "sold"
    t.boolean "activated", default: false
    t.index ["department_id"], name: "index_items_on_department_id"
    t.index ["genre_id"], name: "index_items_on_genre_id"
    t.index ["place_id"], name: "index_items_on_place_id"
  end

  create_table "places", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "tokens", force: :cascade do |t|
    t.integer "item_id", null: false
    t.string "uuid", null: false
    t.datetime "expired_at", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["item_id"], name: "index_tokens_on_item_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "name"
    t.string "email"
    t.string "login"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "wants", force: :cascade do |t|
    t.string "content"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

end
