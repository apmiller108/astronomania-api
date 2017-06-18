class CreateCloseApproaches < ActiveRecord::Migration[5.1]
  def change
    create_table :asteroid_close_approaches do |t|
      t.date :close_approach_date, null: false
      t.integer :epoch_date_close_approach, null: false
      t.jsonb :relative_velocity, null: false, default: {}
      t.jsonb :miss_distance, null: false, default: {}
      t.string :orbiting_body
      t.string :asteroid_near_earth_object_neo_reference_id
    end

    add_foreign_key :asteroid_close_approaches,
                    :asteroid_near_earth_objects,
                    column: :asteroid_near_earth_object_neo_reference_id,
                    primary_key: :neo_reference_id,
                    on_delete: :cascade

    add_index :asteroid_close_approaches,
              :asteroid_near_earth_object_neo_reference_id,
              name: :by_asteroid_near_earth_object_neo_reference_id
  end
end
