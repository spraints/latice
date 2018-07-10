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

ActiveRecord::Schema.define(version: 2018_07_08_122411) do

  create_table "games", force: :cascade do |t|
    t.string "state"
    t.string "identifier"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["identifier"], name: "index_games_on_identifier", unique: true
    t.index ["state"], name: "index_games_on_state"
  end

  create_table "moves", force: :cascade do |t|
    t.integer "game_id"
    t.integer "turn_id"
    t.integer "sequence"
    t.string "details"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["game_id"], name: "index_moves_on_game_id"
    t.index ["turn_id"], name: "index_moves_on_turn_id"
  end

  create_table "players", force: :cascade do |t|
    t.integer "user_id"
    t.integer "game_id"
    t.integer "position"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "ready"
    t.index ["game_id"], name: "index_players_on_game_id"
    t.index ["user_id"], name: "index_players_on_user_id"
  end

  create_table "tiles", force: :cascade do |t|
    t.integer "game_id"
    t.string "identifier"
    t.integer "player_id"
    t.boolean "pool"
    t.integer "board_x"
    t.integer "board_y"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["game_id"], name: "index_tiles_on_game_id"
    t.index ["player_id"], name: "index_tiles_on_player_id"
  end

  create_table "turns", force: :cascade do |t|
    t.integer "game_id"
    t.integer "player_id"
    t.integer "sequence"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["game_id"], name: "index_turns_on_game_id"
    t.index ["player_id"], name: "index_turns_on_player_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "handle"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["handle"], name: "index_users_on_handle", unique: true
  end

end
