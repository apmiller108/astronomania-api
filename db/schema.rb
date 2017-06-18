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

ActiveRecord::Schema.define(version: 20170618014827) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "asteroid_near_earth_objects", id: false, force: :cascade do |t|
    t.string "neo_reference_id", null: false
    t.string "name", null: false
    t.string "nasa_jpl_url"
    t.float "absolute_magnitude", null: false
    t.jsonb "estimated_diameter", default: {}, null: false
    t.boolean "is_potentially_hazardous_asteroid", default: false, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["neo_reference_id"], name: "index_asteroid_near_earth_objects_on_neo_reference_id", unique: true
  end

  create_table "users", force: :cascade do |t|
    t.string "email", null: false
    t.string "password_digest", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_users_on_email", unique: true
  end

end
