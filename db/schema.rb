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

ActiveRecord::Schema.define(version: 20180111044449) do

  create_table "delayed_jobs", force: :cascade do |t|
    t.integer "priority", default: 0, null: false
    t.integer "attempts", default: 0, null: false
    t.text "handler", null: false
    t.text "last_error"
    t.datetime "run_at"
    t.datetime "locked_at"
    t.datetime "failed_at"
    t.string "locked_by"
    t.string "queue"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["priority", "run_at"], name: "delayed_jobs_priority"
  end

  create_table "karaokes", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "kodi_uri"
    t.string "songs_dir"
    t.string "playlist"
    t.string "youtube_api_key"
    t.integer "opening_player"
  end

  create_table "playlists", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "playlists_songs", id: false, force: :cascade do |t|
    t.integer "playlist_id", null: false
    t.integer "song_id", null: false
  end

  create_table "singers", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "songs_count"
  end

  create_table "singers_songs", id: false, force: :cascade do |t|
    t.integer "singer_id", null: false
    t.integer "song_id", null: false
  end

  create_table "songs", force: :cascade do |t|
    t.string "title"
    t.string "singer1"
    t.string "singer2"
    t.string "file"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "number"
    t.string "singer3"
    t.string "singer4"
    t.string "singer_names"
    t.integer "audio_stream", default: 0
    t.index ["number"], name: "index_songs_on_number"
  end

  create_table "youtubes", force: :cascade do |t|
    t.string "channel_id"
    t.string "channel_title"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

end
