module Asteroids
  class OrbitSerializer < ActiveModel::Serializer
    attributes :orbit_id,
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
               :updated_at
  end
end
