class ApodsController < ApplicationController
  def show
    apod = Apod.latest
    render json: apod,
           serializer: ApodSerializer,
           status: :ok
  end
end
