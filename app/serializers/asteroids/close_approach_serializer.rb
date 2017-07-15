module Asteroids
  class CloseApproachSerializer < ActiveModel::Serializer
    attributes :close_approach_date,
               :epoch_date_close_approach,
               :relative_velocity,
               :miss_distance,
               :orbiting_body,
               :updated_at
  end
end
