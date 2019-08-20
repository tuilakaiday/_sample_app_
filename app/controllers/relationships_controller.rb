class RelationshipsController < ApplicationController
  before_action :logged_in_user
  before_action :load_user_follow, only: :create
  before_action :load_relationship, only: :destroy
  after_action :respond_format, only: [:create, :destroy]

  def create
    current_user.follow(@user)
  end

  def destroy
    @user = @relationship.followed
    current_user.unfollow(@user)
  end

  private

  def load_user_follow
    @user = User.find_by id: params[:followed_id]
    unless @user
      flash[:warning] = t ".user_notfound"
      redirect_to notfound_path
    end
  end

  def load_relationship
    @relationship = Relationship.find_by id: params[:id]
    unless @relationship
      flash[:warning] = t ".relationship_notfound"
      redirect_to notfound_path
    end
  end

  def respond_format
    respond_to do |format|
      format.html{redirect_to @user}
      format.js
    end
  end
end
