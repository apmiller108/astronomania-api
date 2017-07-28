class UsersController < ApplicationController
  def create
    user = User.create!(user_params)
    render json: user,
           serializer: UserSerializer,
           status: :created
  end

  private

  def user_params
    params.require(:user).permit(:email,
                                 :password,
                                 :password_confirmation)
  end
end
