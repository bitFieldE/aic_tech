class TopController < ApplicationController
  before_action :logined_check, only: [:login]

  def index
    @articles = Article.visible.order(released_at: :desc).limit(5)
    @articles = @articles.open_to_the_public unless current_user
  end

  def login
  end

  def bad_request
    raise  ActionController::ParameterMissing, ""
  end

  def forbidden
    raise Forbidden, ""
  end

  def internal_server_error
    raise
  end
end
