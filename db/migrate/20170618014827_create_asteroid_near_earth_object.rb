class CreateAsteroidNearEarthObject < ActiveRecord::Migration[5.1]
  def change
    create_table(:asteroid_near_earth_objects,
                 id: false,
                 primary_key: :neo_reference_id) do |t|
      t.string :neo_reference_id, null: false
      t.string :name, null: false
      t.string :nasa_jpl_url
      t.float :absolute_magnitude, null: false
      t.jsonb :estimated_diameter, null: false, default: {}
      t.boolean :is_potentially_hazardous_asteroid, null: false, default: false
      t.timestamps
    end

    add_index :asteroid_near_earth_objects, :neo_reference_id, unique: true
  end
end
