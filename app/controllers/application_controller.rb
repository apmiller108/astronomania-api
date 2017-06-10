class ApplicationController < ActionController::API
  rescue_from ActiveRecord::RecordInvalid, with: :render_record_invalid
  rescue_from ActiveRecord::RecordNotFound, with: :render_not_found

  private

  def render_record_invalid(exception)
    render json: { errors: exception.record.errors },
           status: :unprocessable_entity
  end

  def render_not_found
    render json: { errors: [I18n.t(:detail, scope: 'errors.not_found')] },
           status: :not_found
  end
end
