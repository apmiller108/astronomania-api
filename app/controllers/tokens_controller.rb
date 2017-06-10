class TokensController < ApplicationController
  def create
    user = User.find_by_email! token_params[:email]

    if user.authenticate(token_params[:password])
      render json: 'token',
             serializer: TokenSerializer,
             status: :ok
    else
      render_not_found
    end
  end

  private

  def token_params
    params.require(:authenticate).permit(:email, :password)
  end
end
