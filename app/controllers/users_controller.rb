class UsersController < ApplicationController

  def show
    @comment = Comment.new
    @current_user_posts = Post.user_profile_posts(current_user.id)
      .page(params[:page]).per(Settings.post_per_page)
  end
end
