module Asteroids
  class NearEarthObjectSerializer < ActiveModel::Serializer
    has_one :orbit
    has_many :close_approaches

    attributes :id,
               :name,
               :nasa_jpl_url,
               :absolute_magnitude_h,
               :estimated_diameter,
               :is_potentially_hazardous_asteroid

    attribute :orbital_data do
      Asteroids::OrbitSerializer.new object.orbit if object.orbit
    end
  end
end
