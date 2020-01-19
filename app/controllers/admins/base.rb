class Admins::Base < ApplicationController
  before_action :admins_login_required

  private def admins_login_required
    raise Forbidden unless current_user&.administrator?
  end
end
