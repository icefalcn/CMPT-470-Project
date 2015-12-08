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

ActiveRecord::Schema.define(version: 20151207224438) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "movies", primary_key: "movieid", force: :cascade do |t|
    t.string  "title",       null: false
    t.string  "genre",       null: false
    t.date    "year",        null: false
    t.integer "rating",      null: false
    t.string  "urlink",      null: false
    t.string  "synopsys",    null: false
    t.string  "urlandscape", null: false
  end

  add_index "movies", ["title"], name: "movies_title_key", unique: true, using: :btree

  create_table "users", primary_key: "uid", force: :cascade do |t|
    t.string "email"
  end

  create_table "vote", id: false, force: :cascade do |t|
    t.integer "uid"
    t.integer "movieid"
    t.integer "status"
  end

  create_table "watchlists", id: false, force: :cascade do |t|
    t.integer "uid"
    t.integer "movieid"
  end

  add_foreign_key "vote", "movies", column: "movieid", primary_key: "movieid", name: "vote_movieid_fkey"
  add_foreign_key "watchlists", "movies", column: "movieid", primary_key: "movieid", name: "watchlists_movieid_fkey"
end
