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

ActiveRecord::Schema.define(:version => 20120827034819) do

  create_table "part_types", :force => true do |t|
    t.string   "type_name",  :null => false
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "part_types", ["type_name"], :name => "index_part_types_on_type_name", :unique => true

  create_table "parts", :force => true do |t|
    t.integer  "team_id",         :null => false
    t.integer  "part_type_id",    :null => false
    t.integer  "part_year",       :null => false
    t.string   "part_identifier", :null => false
    t.datetime "created_at",      :null => false
    t.datetime "updated_at",      :null => false
  end

  add_index "parts", ["part_identifier"], :name => "index_parts_on_part_identifier", :unique => true
  add_index "parts", ["part_type_id"], :name => "index_parts_on_part_type_id"
  add_index "parts", ["part_year"], :name => "index_parts_on_part_year"
  add_index "parts", ["team_id"], :name => "index_parts_on_team_id"

  create_table "teams", :force => true do |t|
    t.string   "team_name",  :null => false
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "teams", ["team_name"], :name => "index_teams_on_team_name", :unique => true

end
