class Supports::ViewSupport
  attr_reader :current_user

  def initialize args = {}
    @current_user = args[:current_user]
  end

  def current_user_posts_build
    @current_user.posts.build
  end

  def init_comment
    Comment.new
  end

  def show_all_posts
    Post.all.order_by_time.includes(:user, :comments)
  end
end
