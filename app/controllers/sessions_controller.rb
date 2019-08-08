class SessionsController < ApplicationController
  def new; end

  def create
    user = User.find_by(email: params[:session][:email].downcase)
    if user&.authenticate(params[:session][:password])
      log_in user
      check_remember user
      redirect_back_or user
    else
      flash.now[:danger] = t(".flash_login_error_message")
      render :new
    end
  end

  def destroy
    log_out
    redirect_to root_path
  end

  def check_remember user
    if params[:session][:remember_me] == Settings.remember
      remember(user)
    else
      forget(user)
    end
  end
end
