module Asteroid
  class CloseApproach < ApplicationRecord
    belongs_to :near_earth_object,
               class_name: 'Asteroid::NearEarthObject',
               foreign_key: :asteroid_near_earth_object_neo_reference_id,
               primary_key: :neo_reference_id

    validates :close_approach_date,
              :epoch_date_close_approach,
              :relative_velocity,
              :miss_distance,
              presence: true
  end
end
