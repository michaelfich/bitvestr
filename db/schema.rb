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

ActiveRecord::Schema.define(version: 20150815041349) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "collaborations", force: :cascade do |t|
    t.integer  "strategy_id"
    t.integer  "user_id"
    t.boolean  "confirmed"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  add_index "collaborations", ["strategy_id"], name: "index_collaborations_on_strategy_id", using: :btree
  add_index "collaborations", ["user_id"], name: "index_collaborations_on_user_id", using: :btree

  create_table "formulas", force: :cascade do |t|
    t.string  "name"
    t.string  "abbreviation"
    t.string  "full_name"
    t.integer "order_number"
  end

  add_index "formulas", ["order_number"], name: "index_formulas_on_order_number", using: :btree

  create_table "indicators", force: :cascade do |t|
    t.integer  "strategy_id"
    t.string   "name"
    t.integer  "value"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.integer  "period"
    t.integer  "comparison"
  end

  add_index "indicators", ["strategy_id"], name: "index_indicators_on_strategy_id", using: :btree

  create_table "strategies", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "interval"
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
    t.string   "name"
    t.string   "classification"
  end

  add_index "strategies", ["user_id"], name: "index_strategies_on_user_id", using: :btree

  create_table "ticks", force: :cascade do |t|
    t.integer  "interval"
    t.float    "last_price"
    t.float    "volume"
    t.datetime "datetime"
  end

  create_table "users", force: :cascade do |t|
    t.string   "email",            null: false
    t.string   "crypted_password"
    t.string   "salt"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "first_name"
    t.string   "last_name"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree

  add_foreign_key "collaborations", "strategies"
  add_foreign_key "collaborations", "users"
  add_foreign_key "indicators", "strategies"
  add_foreign_key "strategies", "users"
end
