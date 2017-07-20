class ProfilesController < ApplicationController
  before_action :authenticate_request

  def show
    render json: current_user, serializer: UserSerializer, status: :ok
  end
end
