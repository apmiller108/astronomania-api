module Asteroids
  class NearEarthObjectsStatsController < ApplicationController
    def show
      neo_stats = Asteroid::NearEarthObjectStats.new

      render json: neo_stats,
             serializer: Asteroids::NearEarthObjectsStatsSerializer,
             status: :ok
    end
  end
end
