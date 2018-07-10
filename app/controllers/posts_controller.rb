class PostsController < ApplicationController
  before_action :authenticate_user!
  before_action :load_post, only: %i(show destroy)

  def create
    @post = current_user.posts.build post_params
    if post.save
      flash[:success] = t "messages.created_post"
    else
      flash[:danger] = t "messages.created_post_fail"
    end
      redirect_to root_url
  end

  def show; end

  def destroy
    if post.destroy
      respond_to do |format|
        format.html {redirect_to root_url}
        format.js
      end
    end
  end

  private

  attr_reader :post

  def post_params
    params.require(:post).permit Post::ATTRIBUTE_PARAMS
  end

  def load_post
    @post = Post.find_by id: params[:id]

    return if post
    flash[:danger] = t "messages.not_found" + params[:id]
    redirect_to root_url
  end
end
