class SessionsController < ApplicationController
  def new
  end

  def create
    user = User.find_by(email: session_params[:email]) #Search users by sending email address

    if user&.authenticate(session_params[:password])
      session[:user_id] = user.id
      redirect_to_root_url, notice:'ログインしました。'
    else
      render :new
    end
  end

private
  def session_params 　#Send parameters securely
    params.require(:session).permit(:email, :password)
  end
end
