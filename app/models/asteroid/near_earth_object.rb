module Asteroid
  class NearEarthObject < ApplicationRecord
    has_many :close_approaches,
             class_name: 'Asteroid::CloseApproach',
             foreign_key: :asteroid_near_earth_object_neo_reference_id

    has_one :orbit,
            class_name: 'Asteroid::Orbit',
            foreign_key: :asteroid_near_earth_object_neo_reference_id

    validates :name, :neo_reference_id, presence: true

    store :estimated_diameter, accessors: %i[kilometers meters miles feet]

    alias_attribute :id, :neo_reference_id

    def self.last_updated
      order(updated_at: :desc).limit(1).pluck(:updated_at).first
    end
  end
end
