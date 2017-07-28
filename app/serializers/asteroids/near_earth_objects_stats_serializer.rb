module Asteroids
  class NearEarthObjectsStatsSerializer < ActiveModel::Serializer
    attributes :near_earth_object_count,
               :close_approach_count,
               :last_updated,
               :source,
               :source_info_url
  end
end
