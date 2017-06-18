module Asteroid
  class CloseApproach < ApplicationRecord
    belongs_to :near_earth_object, class_name: 'Asteroid::NearEarthObject'

    alias_attribute :id, :orbital_id
  end
end
