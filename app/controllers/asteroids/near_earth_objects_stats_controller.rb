module Asteroids
  class NearEarthObjectStatsController < ApplicationController
    def show
      neo_stats = Asteroid::NearEarthObjectStats.new
    end
  end
end
