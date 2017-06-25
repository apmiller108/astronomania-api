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

ActiveRecord::Schema.define(version: 20170625194720) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "apods", force: :cascade do |t|
    t.string "copyright"
    t.date "date", null: false
    t.text "explanation", null: false
    t.string "hdurl"
    t.string "media_type"
    t.string "service_version"
    t.string "title", null: false
    t.string "url", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "asteroid_close_approaches", force: :cascade do |t|
    t.date "close_approach_date", null: false
    t.string "epoch_date_close_approach", null: false
    t.jsonb "relative_velocity", default: {}, null: false
    t.jsonb "miss_distance", default: {}, null: false
    t.string "orbiting_body"
    t.string "asteroid_near_earth_object_neo_reference_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["asteroid_near_earth_object_neo_reference_id"], name: "by_asteroid_near_earth_object_neo_reference_id"
  end

  create_table "asteroid_near_earth_objects", primary_key: "neo_reference_id", id: :string, force: :cascade do |t|
    t.string "name", null: false
    t.string "nasa_jpl_url"
    t.float "absolute_magnitude_h"
    t.jsonb "estimated_diameter", default: {}
    t.boolean "is_potentially_hazardous_asteroid", default: false, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "asteroid_orbits", force: :cascade do |t|
    t.integer "orbit_id", null: false
    t.datetime "orbit_determination_date", null: false
    t.integer "orbit_uncertainty", null: false
    t.decimal "minimum_orbit_intersection", null: false
    t.decimal "jupiter_tisserand_invariant", null: false
    t.decimal "epoch_osculation", null: false
    t.decimal "eccentricity", null: false
    t.decimal "semi_major_axis", null: false
    t.decimal "inclination", null: false
    t.decimal "ascending_node_longitude", null: false
    t.decimal "orbital_period", null: false
    t.decimal "perihelion_distance", null: false
    t.decimal "perihelion_argument", null: false
    t.decimal "aphelion_distance", null: false
    t.decimal "perihelion_time", null: false
    t.decimal "mean_anomaly", null: false
    t.decimal "mean_motion", null: false
    t.string "equinox", null: false
    t.string "asteroid_near_earth_object_neo_reference_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["asteroid_near_earth_object_neo_reference_id"], name: "orbit_by_asteroid_near_earth_object_neo_reference_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", null: false
    t.string "password_digest", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_users_on_email", unique: true
  end

  add_foreign_key "asteroid_close_approaches", "asteroid_near_earth_objects", column: "asteroid_near_earth_object_neo_reference_id", primary_key: "neo_reference_id", on_delete: :cascade
  add_foreign_key "asteroid_orbits", "asteroid_near_earth_objects", column: "asteroid_near_earth_object_neo_reference_id", primary_key: "neo_reference_id", on_delete: :cascade
end
