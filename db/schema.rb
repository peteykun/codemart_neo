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

ActiveRecord::Schema.define(version: 20150401100400) do

  create_table "auctions", force: :cascade do |t|
    t.integer  "problem_id",  limit: 4
    t.integer  "winning_bid", limit: 4
    t.datetime "start_time"
    t.datetime "end_time"
    t.datetime "created_at",            null: false
    t.datetime "updated_at",            null: false
    t.boolean  "active",      limit: 1
  end

  create_table "bids", force: :cascade do |t|
    t.integer  "auction_id", limit: 4
    t.integer  "user_id",    limit: 4
    t.integer  "amount",     limit: 4
    t.datetime "created_at",           null: false
    t.datetime "updated_at",           null: false
  end

  create_table "config_tables", force: :cascade do |t|
    t.string   "key",        limit: 255
    t.string   "value",      limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "free_pool_items", force: :cascade do |t|
    t.integer  "problem_id", limit: 4
    t.datetime "created_at",           null: false
    t.datetime "updated_at",           null: false
  end

  create_table "problems", force: :cascade do |t|
    t.integer  "difficulty",      limit: 4
    t.text     "statement",       limit: 65535
    t.text     "sample_input",    limit: 65535
    t.text     "sample_output",   limit: 65535
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "name",            limit: 255
    t.integer  "reward",          limit: 4
    t.integer  "base_price",      limit: 4
    t.text     "short_statement", limit: 65535
  end

  create_table "problems_users", force: :cascade do |t|
    t.integer "problem_id", limit: 4
    t.integer "user_id",    limit: 4
  end

  create_table "runs", force: :cascade do |t|
    t.integer  "problem_id",      limit: 4
    t.text     "code",            limit: 65535
    t.text     "input",           limit: 65535
    t.text     "expected_output", limit: 65535
    t.text     "output",          limit: 65535
    t.boolean  "success",         limit: 1
    t.datetime "timestamp"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "user_id",         limit: 4
    t.boolean  "tested",          limit: 1
  end

  create_table "test_cases", force: :cascade do |t|
    t.integer  "problem_id", limit: 4
    t.text     "input",      limit: 65535
    t.text     "output",     limit: 65535
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", force: :cascade do |t|
    t.string   "email",           limit: 255
    t.string   "password_digest", limit: 255
    t.boolean  "is_admin",        limit: 1
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "username",        limit: 255
    t.string   "gender",          limit: 255
    t.string   "name",            limit: 255
    t.string   "college",         limit: 255
    t.integer  "balance",         limit: 4
  end

end
