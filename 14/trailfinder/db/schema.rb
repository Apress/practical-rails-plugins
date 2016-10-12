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

  create_table "trails", :force => true do |t|
    t.string   "name"
    t.integer  "usgs_id",    :limit => 11
    t.string   "state"
    t.string   "county"
    t.decimal  "latitude",                 :precision => 15, :scale => 10
    t.decimal  "longitude",                :precision => 15, :scale => 10
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
