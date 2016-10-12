# This file is auto-generated from the current state of the database. Instead of editing this file, 
# please use the migrations feature of Active Record to incrementally modify your database, and
# then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your database schema. If you need
# to create the application database on another system, you should be using db:schema:load, not running
# all the migrations from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 1) do

  create_table "car_versions", :force => true do |t|
    t.integer  "car_id"
    t.integer  "version"
    t.string   "make"
    t.string   "model"
    t.integer  "year"
    t.decimal  "price"
    t.boolean  "is_on_lot"
    t.boolean  "is_sold"
    t.boolean  "is_paid_in_full"
    t.text     "notes"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "cars", :force => true do |t|
    t.string   "make"
    t.string   "model"
    t.integer  "year"
    t.decimal  "price"
    t.boolean  "is_on_lot"
    t.boolean  "is_sold"
    t.boolean  "is_paid_in_full"
    t.text     "notes"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "version"
  end

end
