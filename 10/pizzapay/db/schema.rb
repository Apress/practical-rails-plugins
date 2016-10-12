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

  create_table "order_items", :force => true do |t|
    t.integer "order_id"
    t.integer "pizza_id"
    t.integer "quantity", :default => 0
  end

  create_table "orders", :force => true do |t|
    t.string   "customer_name"
    t.string   "customer_email"
    t.string   "customer_phone"
    t.string   "customer_address"
    t.string   "customer_city"
    t.string   "authorization"
    t.boolean  "paid",             :default => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "pizzas", :force => true do |t|
    t.string   "name"
    t.text     "description"
    t.integer  "price",       :default => 0
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
