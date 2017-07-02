module Admin
  class BaseController < ApplicationController
    private

    def require_admin
      # render_unauthorized unless current_user.admin?
    end
  end
end
