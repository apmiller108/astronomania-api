module Asteroid
  class NearEarthObject < ApplicationRecord
    has_many :close_approaches,
             class_name: 'Asteroid::CloseApproach',
             foreign_key: :asteroid_near_earth_object_neo_reference_id

    validates :name,
              :absolute_magnitude_h,
              :estimated_diameter,
              presence: true

    store :estimated_diameter, accessors: %i[kilometers meters miles feet]

    alias_attribute :id, :neo_reference_id
  end
end
