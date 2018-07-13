class StaticPagesController < ApplicationController
  before_action :load_view_support, only: %i(home)

  def home
    @items = support.show_all_posts.page(params[:page]).per(Settings.post_per_page)
  end

  private

  attr_reader :support

  def load_view_support
    @support = Supports::ViewSupport.new current_user: current_user
  end

  def comment_params
    params.require(:comment).permit Comment::ATTRIBUTE_PARAMS
  end
end
