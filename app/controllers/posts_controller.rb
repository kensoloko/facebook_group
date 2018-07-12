class PostsController < ApplicationController
  before_action :authenticate_user!
  before_action :load_post, only: %i(show destroy)
  before_action :load_group, only: %i(create)

  def create
    @post = current_user.posts.build post_params
    if post.save
      flash[:success] = t "messages.created_post"
    else
      flash[:danger] = t "messages.created_post_fail"
    end

    if params[:post][:group_id].present?
      redirect_to group
    else
      redirect_to root_url
    end
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

  attr_reader :post, :group

  def post_params
    params.require(:post).permit Post::ATTRIBUTE_PARAMS
  end

  def load_group
    @group = Group.find_by id: params[:post][:group_id]
  end

  def load_post
    @post = Post.find_by id: params[:id]

    return if post
    flash[:danger] = t "messages.not_found" + params[:id]
    redirect_to root_path
  end
end
