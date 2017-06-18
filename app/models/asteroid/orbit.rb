module Asteroid
  class Orbit < ApplicationRecord
    belongs_to :near_earth_object,
               class_name: 'Asteroid::NearEarthObject',
               foreign_key: :asteroid_near_earth_object_neo_reference_id,
               primary_key: :neo_reference_id

    validates :orbit_id,
              :orbit_determination_date,
              :orbit_uncertainty,
              :minimum_orbit_intersection,
              :jupiter_tisserand_invariant,
              :epoch_osculation,
              :eccentricity,
              :semi_major_axis,
              :inclination,
              :ascending_node_longitude,
              :orbital_period,
              :perihelion_distance,
              :perihelion_argument,
              :aphelion_distance,
              :perihelion_time,
              :mean_anomaly,
              :mean_motion,
              :equinox,
              presence: true
  end
end
