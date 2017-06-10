class JsonWebTokensController < ApplicationController
  def create
    user = User.find_by_email! token_params[:email]

    if user.authenticate(token_params[:password])
      token = JsonWebToken.new(payload: { user_id: user.id })
      render json: token,
             serializer: JsonWebTokenSerializer,
             adapter: :attributes,
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
