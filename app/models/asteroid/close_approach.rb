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
      kilometers_per_second BigDecimal
      kilometers_per_hour BigDecimal
      miles_per_hour BigDecimal
    end

    store_attributes :miss_distance do
      astronomical BigDecimal
      lunar BigDecimal
      kilometers BigDecimal
      miles BigDecimal
    end
  end
end
