class UsersController < ApplicationController
  before_action :logged_in_user, except: [:new, :create, :show]
  before_action :load_user, except: [:new, :create, :index]
  before_action :correct_user, only: [:edit, :update]
  before_action :admin_user, only: :destroy

  def new
    @user = User.new
  end

  def create
    @user = User.new user_params
    if @user.save
      @user.send_activation_email
      flash[:info] = t ".check_your_email"
      redirect_to root_url
    else
      render :new
    end
  end

  def index
    @users = User.activated.paginate(page: params[:page],
              per_page: Settings.per_page)
  end

  def show
    redirect_to(root_url) && return unless @user.activated
    @microposts = @user.microposts.paginate(page: params[:page])
  end

  def edit; end

  def update
    if @user.update_attributes(user_params)
      flash[:success] = t ".success_update_messages"
      redirect_to @user
    else
      render :edit
    end
  end

  def destroy
    if @user.destroy
      flash[:success] = t ".success_deleted_message"
      redirect_to users_url
    else
      flash.now[:danger] = t ".warning_notfound_user"
      redirect_to root_path
    end
  end

  private
  def user_params
    params.require(:user).permit(:name, :email, :password,
      :password_confirmation)
  end

  def correct_user
    redirect_to(root_path) unless current_user?(@user)
  end

  def admin_user
    redirect_to(root_path) unless current_user.admin?
  end

  def load_user
    @user = User.find_by(id: params[:id])
    return if @user
    flash.now[:danger] = t ".warning_notfound_user"
    redirect_to root_path
  end
end
