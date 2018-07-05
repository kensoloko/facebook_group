class StaticPagesController < ApplicationController

  def home
    if signed_in?
      @post = current_user.posts.build
      @items = Post.all.order_by_time.includes(:user, :comments).page(params[:page]).
        per(Settings.post_per_page)
    else
      @items = Post.all.order_by_time.includes(:user, :comments).page(params[:page]).
        per(Settings.post_per_page)
    end
  end
end
