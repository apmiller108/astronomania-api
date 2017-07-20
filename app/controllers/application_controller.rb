require 'tokenizer'

class ApplicationController < ActionController::API
  rescue_from ActiveRecord::RecordInvalid, with: :render_record_invalid
  rescue_from ActiveRecord::RecordNotFound, with: :render_not_found

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

  def render_error(message:, status: :unprocessable_entity)
    render json: { errors: [message] },
           status: status
  end

  def authenticate_request
    return render_unauthorized unless valid_auth_token?
    load_current_user
  end

  def valid_auth_token?
    return false unless request.headers['Authorization']
    decoded_auth_token
  end

  def decoded_auth_token
    @decoded_token ||= Tokenizer.decode(auth_token_from_header)
  end

  def auth_token_from_header
    request.headers['Authorization'].split.last
  end

  def load_current_user
    user_id = decoded_auth_token[0]['payload']['user_id']
    @current_user = User.find(user_id)
  end
end
