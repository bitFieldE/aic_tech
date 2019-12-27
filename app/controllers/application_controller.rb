class ApplicationController < ActionController::Base

  # set login_id
  private def current_user
    return User.find_by(id: session[:user_id]) if session[:user_id]
  end
  helper_method :current_user

  class LoginRequired < StandardError; end
  class Forbidden < StandardError; end
  if Rails.env.production? || ENV["RESCUE_EXCEPTIONS"]
    rescue_from StandardError, with: :rescue_internal_server_error
    rescue_from ActiveRecord::RecordNotFound, with: :rescue_not_found
    rescue_from ActionController::ParameterMissing, with: :rescue_bad_request
  end

  rescue_from LoginRequired, with: :rescue_login_required
  rescue_from Forbidden, with: :rescue_forbidden

  # Login request
  private def login_required
    redirect_to "/login", alert: "ログインしてください" unless current_user
  end

  private def logined_check
    redirect_to :root if current_user
  end

  private def rescue_bad_request(exception)
    render "errors/bad_request", status: 400, formats: [:html]
  end

  private def rescue_login_required(exception)
    redirect_to "/login", status: 403, alert: "ログインしてください"
  end

  private def rescue_forbidden(exception)
    render "errors/forbidden", status: 403, formats: [:html]
  end

  private def rescue_not_found(exception)
    render "errors/not_found", status: 404, formats: [:html]
  end

  private def rescue_internal_server_error(exception)
    render "errors/internal_server_error", status: 500, formats: [:html]
  end
end
