module Asteroid
  class NearEarthObject < ApplicationRecord
    validates :name,
              :absolute_magnitude_h,
              :estimated_diameter,
              presence: true

    store :estimated_diameter, accessors: %i[kilometers meters miles feet]
    alias_attribute :id, :neo_reference_id
  end
end
