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

ActiveRecord::Schema.define(version: 20140204234137) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

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
    t.date     "date"
    t.integer  "rating",     default: 0, null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "photos", ["source", "uid"], name: "index_photos_on_source_and_uid", unique: true, using: :btree

  create_table "users", force: :cascade do |t|
    t.string   "login",      null: false
    t.string   "email",      null: false
    t.string   "first_name"
    t.string   "last_name"
    t.string   "userpic"
    t.text     "profile"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "users", ["email"], name: "index_users_on_email", using: :btree
  add_index "users", ["login"], name: "index_users_on_login", using: :btree

end
