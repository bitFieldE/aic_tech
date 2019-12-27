class SessionsController < ApplicationController
  def create
    user = User.find_by(email: params[:email])
    if user&.authenticate(params[:password])
      session[:user_id] = user.id
      redirect_to :root, notice: "ログインしました"
    else
      redirect_to "/login", alert: "ユーザー名かパスワードが間違っています"
    end
  end

  def destroy
    session.delete(:user_id)
    redirect_to :root
  end
end
