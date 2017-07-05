module Asteroids
  class NearEarthObjectSerializer < ActiveModel::Serializer
    has_one :orbit, class_name: 'Asteroid::Orbit'
    has_many :close_approaches, class_name: 'Asteroid::CloseApproach'
  end
end
