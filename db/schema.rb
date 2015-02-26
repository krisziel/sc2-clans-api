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

ActiveRecord::Schema.define(version: 20150225012711) do

  create_table "clans", force: true do |t|
    t.string   "name"
    t.string   "tag"
    t.string   "region"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "ggplayers", force: true do |t|
    t.integer  "player_id"
    t.integer  "matches_count"
    t.integer  "hours_played"
    t.string   "most_played_race"
    t.integer  "highest_league_type"
    t.integer  "highest_league_rank"
    t.integer  "solo_league"
    t.integer  "solo_rank"
    t.integer  "twos_league"
    t.integer  "twos_rank"
    t.integer  "threes_league"
    t.integer  "threes_rank"
    t.integer  "fours_league"
    t.integer  "fours_rank"
    t.integer  "achievement_points"
    t.integer  "season_games"
    t.integer  "career_games"
    t.integer  "apm"
    t.integer  "bnetid"
    t.string   "portrait"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "ggsiteid"
  end

  create_table "ladders", force: true do |t|
    t.string   "name"
    t.integer  "bnet_id"
    t.integer  "division"
    t.string   "league"
    t.string   "region"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "players", force: true do |t|
    t.string   "name"
    t.integer  "bnet_id"
    t.integer  "ggsiteid"
    t.integer  "ggplayer_id"
    t.string   "highest_solo"
    t.string   "highest_team"
    t.integer  "terran_level"
    t.integer  "protoss_level"
    t.integer  "zerg_level"
    t.string   "region"
    t.text     "career"
    t.text     "season"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "clan_id"
    t.string   "clan_tag"
  end

  create_table "team_members", force: true do |t|
    t.integer  "player_id"
    t.integer  "team_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "teams", force: true do |t|
    t.integer  "ladder_id"
    t.integer  "rank"
    t.integer  "points"
    t.integer  "wins"
    t.integer  "losses"
    t.string   "race"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
