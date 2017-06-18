class CreateAsteroidOrbits < ActiveRecord::Migration[5.1]
  def change
    create_table :asteroid_orbits, id: false, primary_key: :orbit_id do |t|
      t.integer :orbit_id, null: false
      t.datetime :orbit_determination_date, null: false
      t.integer :orbit_uncertainty, null: false
      t.decimal :minimum_orbit_intersection, null: false
      t.decimal :jupiter_tisserand_invariant, null: false
      t.decimal :epoch_osculation, null: false
      t.decimal :eccentricity, null: false
      t.decimal :semi_major_axis, null: false
      t.decimal :inclination, null: false
      t.decimal :ascending_node_longitude, null: false
      t.decimal :orbital_period, null: false
      t.decimal :perihelion_distance, null: false
      t.decimal :perihelion_argument, null: false
      t.decimal :aphelion_distance, null: false
      t.decimal :perihelion_time, null: false
      t.decimal :mean_anomaly, null: false
      t.decimal :mean_motion, null: false
      t.string :equinox, null: false
      t.string :asteroid_near_earth_object_neo_reference_id
    end

    add_foreign_key :asteroid_orbits,
                    :asteroid_near_earth_objects,
                    column: :asteroid_near_earth_object_neo_reference_id,
                    primary_key: :neo_reference_id,
                    on_delete: :cascade

    add_index :asteroid_orbits,
              :asteroid_near_earth_object_neo_reference_id,
              name: :orbit_by_asteroid_near_earth_object_neo_reference_id
  end
end
