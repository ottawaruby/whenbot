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

ActiveRecord::Schema.define(:version => 20120419234122) do

  create_table "actions", :force => true do |t|
    t.integer  "task_id",                      :null => false
    t.string   "channel",                      :null => false
    t.string   "action",                       :null => false
    t.text     "parameters"
    t.text     "extra_data"
    t.boolean  "active",     :default => true, :null => false
    t.datetime "created_at",                   :null => false
    t.datetime "updated_at",                   :null => false
  end

  add_index "actions", ["active"], :name => "index_actions_on_active"
  add_index "actions", ["channel", "action"], :name => "index_actions_on_channel_and_action"
  add_index "actions", ["task_id"], :name => "index_actions_on_task_id"

  create_table "authentications", :force => true do |t|
    t.string   "channel",    :null => false
    t.text     "parameters"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "authentications", ["channel"], :name => "index_authentications_on_channel", :unique => true

  create_table "tasks", :force => true do |t|
    t.string   "name"
    t.datetime "last_executed"
    t.boolean  "active",        :default => true, :null => false
    t.datetime "created_at",                      :null => false
    t.datetime "updated_at",                      :null => false
  end

  add_index "tasks", ["active"], :name => "index_tasks_on_active"

  create_table "triggers", :force => true do |t|
    t.integer  "task_id",                            :null => false
    t.string   "channel",                            :null => false
    t.string   "trigger",                            :null => false
    t.boolean  "polling_trigger", :default => false, :null => false
    t.text     "parameters"
    t.text     "match_data"
    t.datetime "last_matched"
    t.text     "extra_data"
    t.string   "webhook_uid"
    t.boolean  "active",          :default => true,  :null => false
    t.datetime "created_at",                         :null => false
    t.datetime "updated_at",                         :null => false
  end

  add_index "triggers", ["active", "polling_trigger"], :name => "index_triggers_on_active_and_polling_trigger"
  add_index "triggers", ["active"], :name => "index_triggers_on_active"
  add_index "triggers", ["channel", "trigger"], :name => "index_triggers_on_channel_and_trigger"
  add_index "triggers", ["polling_trigger"], :name => "index_triggers_on_polling_trigger"
  add_index "triggers", ["task_id"], :name => "index_triggers_on_task_id"

end
