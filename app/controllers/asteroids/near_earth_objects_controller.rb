module Asteroids
  class NearEarthObjectsController < ApplicationController
    def index
      results = Paginate.for(relation: Asteroid::NearEarthObject.all,
                             path: request.env['PATH_INFO'],
                             params: params)

      render json: results.records,
             meta: results.meta_data,
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
