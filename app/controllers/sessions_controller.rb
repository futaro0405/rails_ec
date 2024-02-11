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
      render :new, status: :unprocessable_entity
    end
  end

  def destroy
    reset_session
    redirect_to root_url, notice: "logout", status: :see_other
  end

  private

  def session_params
    params.require(:session).permit(:name, :password)
  end
end
