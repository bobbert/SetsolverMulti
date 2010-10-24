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

ActiveRecord::Schema.define(:version => 20101024042019) do

  create_table "cardfaces", :force => true do |t|
    t.integer "number"
    t.string  "color",          :limit => 30
    t.string  "color_abbrev",   :limit => 3
    t.string  "shading",        :limit => 30
    t.string  "shading_abbrev", :limit => 3
    t.string  "shape",          :limit => 30
    t.string  "shape_abbrev",   :limit => 3
  end

  create_table "cards", :force => true do |t|
    t.integer "cardface_id"
    t.integer "deck_id"
    t.integer "facedown_position"
    t.integer "faceup_position"
    t.integer "threecardset_id"
  end

  add_index "cards", ["cardface_id"], :name => "cardface_card_id_fkey"
  add_index "cards", ["deck_id"], :name => "deck_card_id_fkey"
  add_index "cards", ["threecardset_id"], :name => "card_threecardset_id_fkey"

  create_table "decks", :force => true do |t|
    t.integer  "game_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.datetime "finished_at"
  end

  add_index "decks", ["game_id"], :name => "game_deck_id_fkey"

  create_table "facebook_templates", :force => true do |t|
    t.string "template_name", :null => false
    t.string "content_hash",  :null => false
    t.string "bundle_id"
  end

  add_index "facebook_templates", ["template_name"], :name => "index_facebook_templates_on_template_name", :unique => true

  create_table "games", :force => true do |t|
    t.integer  "selection_count",                  :default => 0
    t.string   "name",               :limit => 50
    t.datetime "last_played_at"
    t.datetime "started_at"
    t.datetime "finished_at"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "postgame_published"
  end

  create_table "players", :force => true do |t|
    t.integer  "wins",           :default => 0
    t.integer  "losses",         :default => 0
    t.integer  "rating",         :default => 1000
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "user_id"
    t.integer  "skill_level_id"
  end

  add_index "players", ["user_id"], :name => "player_user_id_fkey"

  create_table "scores", :force => true do |t|
    t.integer  "player_id"
    t.integer  "game_id"
    t.integer  "points",     :default => 0
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "scores", ["game_id"], :name => "score_game_id_fkey"
  add_index "scores", ["player_id"], :name => "score_player_id_fkey"

  create_table "skill_levels", :force => true do |t|
    t.string   "name"
    t.integer  "threshold_time_in_seconds"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "threecardsets", :force => true do |t|
    t.integer  "player_id"
    t.integer  "seconds_to_find"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", :force => true do |t|
    t.string   "email"
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "facebook_id"
    t.string   "facebook_session_key"
  end

  add_index "users", ["email"], :name => "index_users_on_email", :unique => true

end
