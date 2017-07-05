module Asteroids
  class NearEarthObjectsController < ApplicationController
    skip_before_action :authenticate_request, only: [:index]

    def index
      neos = Asteroid::NearEarthObject.all
      render json: neos,
             each_serializer: Asteroids::NearEarthObjectSerializer,
             status: :ok
    end
  end
end
