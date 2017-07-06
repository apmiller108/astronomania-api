module Asteroids
  class NearEarthObjectsController < ApplicationController
    skip_before_action :authenticate_request, only: [:index, :show]

    def index
      neos = Asteroid::NearEarthObject.all

      render json: neos,
             each_serializer: Asteroids::NearEarthObjectSerializer,
             status: :ok
    end

    def show
      neo = Asteroid::NearEarthObject.find params[:id]

      render json: neo,
             serializer: Asteroids::NearEarthObjectSerializer,
             status: :ok
    end
  end
end
