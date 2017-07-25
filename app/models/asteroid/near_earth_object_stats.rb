module Asteroid
  class NearEarthObjectStats
    include ActiveModel::Serialization

    attr_reader :near_earth_object_count,
                :close_approach_count,
                :last_updated,
                :source,
                :source_info_url

    def self.model_name
      @_model_name ||= :asteroid_near_earth_object_stats
    end

    def initialize
      @near_earth_object_count = Asteroid::NearEarthObject.count
      @close_approach_count = Asteroid::CloseApproach.count
      @last_updated = Asteroid::NearEarthObject.last_updated
      @source = source_of_data
      @source_info_url = 'https://api.nasa.gov/api.html#NeoWS'
    end

    private

    def source_of_data
      "NEO data is from the NASA JPL Asteroid team "\
      "(http://neo.jpl.nasa.gov/). Data is imported from NASA's NeoWs "\
      "(Near Earth Object Web Service) a RESTful web service for near earth "\
      "Asteroid information."
    end
  end
end
