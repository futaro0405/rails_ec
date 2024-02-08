class SessionsController < ApplicationController
  skip_before_action :login_required

  def new
  end

  def create
    user = User.find_by(name: session_params[:name])

    if user&.authenticate(session_params[:password])
      session[:user_id] = user.id
      flash.notice = "login"
      redirect_to root_url
    else
      render :new
    end
  end

  def destroy
    reset_session
      flash.notice = "logout"
      redirect_to root_url
  end

  private

  def session_params
    params.require(:session).permit(:name, :password)
  end
end
