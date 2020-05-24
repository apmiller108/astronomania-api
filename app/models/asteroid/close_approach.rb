module Asteroid
  class CloseApproach < ApplicationRecord
    include Storext.model

    belongs_to :near_earth_object,
               class_name: 'Asteroid::NearEarthObject',
               foreign_key: :asteroid_near_earth_object_neo_reference_id,
               primary_key: :neo_reference_id

    validates :close_approach_date,
              :epoch_date_close_approach,
              :relative_velocity,
              :miss_distance,
              presence: true

    store_attributes :relative_velocity do
      kilometers_per_second Axiom::Types::Decimal
      kilometers_per_hour Axiom::Types::Decimal
      miles_per_hour Axiom::Types::Decimal
    end

    store_attributes :miss_distance do
      astronomical Axiom::Types::Decimal
      lunar Axiom::Types::Decimal
      kilometers Axiom::Types::Decimal
      miles Axiom::Types::Decimal
    end
  end
end
