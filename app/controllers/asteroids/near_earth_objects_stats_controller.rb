module Asteroids
  class NearEarthObjectsStatsController < ApplicationController
    def show
      neo_stats = Asteroid::NearEarthObjectStats.new
    end
  end
end
