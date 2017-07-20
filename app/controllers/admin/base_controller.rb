module Admin
  class BaseController < ApplicationController
    before_action :authenticate_request
    before_action :require_admin

    private

    def require_admin
      render_unauthorized unless current_user.admin?
    end
  end
end
