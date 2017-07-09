module Asteroids
  class NearEarthObjectSerializer < ActiveModel::Serializer
    has_one :orbit, class_name: 'Asteroid::Orbit'
    has_many :close_approaches, class_name: 'Asteroid::CloseApproach'

    attributes :id,
               :name,
               :nasa_jpl_url,
               :absolute_magnitude_h,
               :estimated_diameter,
               :is_potentially_hazardous_asteroid
  end
end
