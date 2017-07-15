module Asteroids
  class NearEarthObjectSerializer < ActiveModel::Serializer
    attributes :id,
               :name,
               :nasa_jpl_url,
               :absolute_magnitude_h,
               :estimated_diameter,
               :is_potentially_hazardous_asteroid

    attribute :orbital_data do
      Asteroids::OrbitSerializer.new object.orbit
    end

    attribute :close_approaches do
      object.close_approaches.map do |close_approach|
        Asteroids::CloseApproachSerializer.new close_approach
      end
    end
  end
end
