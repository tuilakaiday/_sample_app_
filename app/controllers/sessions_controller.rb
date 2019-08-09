class SessionsController < ApplicationController
  def new; end

  def create
    user = User.find_by(email: params[:session][:email].downcase)
    if user&.authenticate(params[:session][:password])
      check_activated? user
    else
      flash.now[:danger] = t ".flash_login_error_message"
      render :new
    end
  end

  def destroy
    log_out if logged_in?
    redirect_to root_path
  end

  def check_remember user
    if params[:session][:remember_me] == Settings.remember
      remember(user)
    else
      forget(user)
    end
  end

  def check_activated? user
    if user.activated?
      log_in user
      check_remember user
      redirect_back_or user
    else
      flash[:warning] = t ".error_activation"
      redirect_to root_url
    end
  end
end
