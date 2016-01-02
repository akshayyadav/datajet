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

ActiveRecord::Schema.define(version: 20160102164240) do

  create_table "diesels", force: :cascade do |t|
    t.date     "reading_at"
    t.integer  "received_stock",                         default: 0,   null: false
    t.integer  "actual_stock",                           default: 0,   null: false
    t.integer  "closing_stock",                          default: 0
    t.integer  "opening_meter",                          default: 0,   null: false
    t.integer  "testing_meter",                          default: 0,   null: false
    t.integer  "actual_sale",                            default: 0
    t.decimal  "purchase_rate",  precision: 6, scale: 3, default: 0.0, null: false
    t.decimal  "sale_rate",      precision: 6, scale: 3, default: 0.0, null: false
    t.integer  "total_stock",                            default: 0,   null: false
    t.integer  "closing_meter",                          default: 0,   null: false
    t.integer  "opening_stock",                          default: 0,   null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "msrecords", force: :cascade do |t|
    t.date     "reading_at"
    t.integer  "received_stock",                         default: 0,   null: false
    t.integer  "actual_stock",                           default: 0,   null: false
    t.integer  "closing_stock",                          default: 0
    t.integer  "opening_meter",                          default: 0,   null: false
    t.integer  "testing_meter",                          default: 0,   null: false
    t.integer  "actual_sale",                            default: 0
    t.decimal  "purchase_rate",  precision: 6, scale: 3, default: 0.0, null: false
    t.decimal  "sale_rate",      precision: 6, scale: 3, default: 0.0, null: false
    t.integer  "total_stock",                            default: 0,   null: false
    t.integer  "closing_meter",                          default: 0,   null: false
    t.integer  "opening_stock",                          default: 0,   null: false
    t.datetime "created_at",                                           null: false
    t.datetime "updated_at",                                           null: false
  end

end
