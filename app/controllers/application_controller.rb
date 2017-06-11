require 'tokenizer'

class ApplicationController < ActionController::API
  rescue_from ActiveRecord::RecordInvalid, with: :render_record_invalid
  rescue_from ActiveRecord::RecordNotFound, with: :render_not_found

  before_action :authenticate_request

  private

  attr_reader :current_user

  def render_record_invalid(exception)
    render json: { errors: exception.record.errors },
           status: :unprocessable_entity
  end

  def render_not_found
    render json: { errors: [I18n.t(:detail, scope: 'errors.not_found')] },
           status: :not_found
  end

  def render_unauthorized
    render json: { errors: [I18n.t(:detail, scope: 'errors.unauthorized')] },
           status: :unauthorized
  end

  def authenticate_request
    return render_unauthorized unless decoded_auth_token_from_headers
    load_current_user
  end

  def decoded_auth_token_from_headers
    return false unless request.headers['Authorization']
    token = request.headers['Authorization'].split.last
    @decoded_token ||= Tokenizer.decode(token)
  end

  def load_current_user
    user_id = decoded_auth_token_from_headers[0]['payload']['user_id']
    @current_user = User.find(user_id)
  end
end
