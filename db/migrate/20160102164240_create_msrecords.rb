class CreateMsrecords < ActiveRecord::Migration
  def change
    create_table :msrecords do |t|

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

      t.timestamps null: false
    end
  end
end
