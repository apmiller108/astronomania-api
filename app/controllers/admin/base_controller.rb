module Admin
  class BaseController < ApplicationController
    before_action :require_admin

    private

    def require_admin
      # TODO: admin check
      # render_unauthorized unless current_user.admin?
    end
  end
end
