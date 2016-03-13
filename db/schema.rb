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

ActiveRecord::Schema.define(version: 20160313191642) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "authentications", force: :cascade do |t|
    t.integer  "user_id",      null: false
    t.string   "provider",     null: false
    t.string   "uid",          null: false
    t.string   "access_token"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
  end

  add_index "authentications", ["uid", "provider"], name: "index_authentications_on_uid_and_provider", unique: true, using: :btree
  add_index "authentications", ["user_id"], name: "index_authentications_on_user_id", using: :btree

  create_table "likes", force: :cascade do |t|
    t.integer  "user_id",    null: false
    t.integer  "photo_id",   null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "likes", ["user_id", "photo_id"], name: "index_likes_on_user_id_and_photo_id", unique: true, using: :btree

  create_table "photos", force: :cascade do |t|
    t.string   "source",                 null: false
    t.string   "uid",                    null: false
    t.string   "state",                  null: false
    t.string   "src"
    t.text     "body"
    t.string   "user_uid",               null: false
    t.string   "username"
    t.string   "fullname"
    t.string   "userpic"
    t.string   "url"
    t.integer  "rating",     default: 0, null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "thumb"
    t.datetime "posted_at"
  end

  add_index "photos", ["source", "uid"], name: "index_photos_on_source_and_uid", unique: true, using: :btree

  create_table "users", force: :cascade do |t|
    t.string   "name"
    t.string   "email"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
