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
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20120422184530) do

  create_table "items", :force => true do |t|
    t.string  "description",                   :null => false
    t.integer "price_in_cents", :default => 0, :null => false
    t.string  "currency"
    t.integer "merchant_id",                   :null => false
  end

  create_table "merchants", :force => true do |t|
    t.string "name"
    t.string "address"
  end

  create_table "purchasers", :force => true do |t|
    t.string "name", :null => false
  end

  create_table "purchases", :force => true do |t|
    t.integer  "purchaser_id", :null => false
    t.integer  "item_id",      :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
