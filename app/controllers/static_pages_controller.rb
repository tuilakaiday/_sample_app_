class StaticPagesController < ApplicationController
  def home
    if logged_in?
      @micropost = current_user.microposts.build
      id = current_user.id
      @feed_items = Micropost.feed(id).order_by.paginate(page: params[:page],
        per_page: Settings.per_page)
    end
  end

  def help; end

  def about; end

  def contact; end

  def not_found; end
end
