class CommentsController < ApplicationController
  before_action :find_comment, only: %i(edit update destroy)

  def create
    @comment = if params[:comment][:parent_id].to_i > 0
                find_comment_parent
              else
                 Comment.new comment_params
              end

    if comment.save
      @post = comment.post
      respond_to do |format|
        format.html{redirect_to :back}
        format.js
      end
    else
      flash[:danger] = t ".messages.create_failed"
      redirect_to root_url
    end
  end

  def edit; end

  def update
    @comment.update_attributes comment_params
    if comment.save
      respond_to do |format|
        format.html{redirect_to :back}
        format.js
      end
    else
      flash[:danger] = t ".messages.update_failed"
      redirect_to root_url
    end
  end

  def destroy
    if @comment.descendants.any?
      comment.descendants.each do |comment_des|
        comment_des.destroy
      end
    end

    if comment.destroy
      respond_to do |format|
        format.html{redirect_to :back}
        format.js
      end
    else
      flash[:danger] = t ".messages.delete_failed"
      redirect_to root_url
    end
  end

  private

  attr_reader :comment

  def comment_params
    params.require(:comment).permit Comment::ATTRIBUTE_PARAMS
  end

  def find_comment_parent
    parent = Comment.find_by id: (params[:comment].delete :parent_id)
    if parent.present?
      parent.children.build comment_params
    else
      flash[:danger] = t ".messages.not_found"
      redirect_to root_url
    end
  end

  def find_comment
    @comment = Comment.find_by id: params[:id]

    return if comment
    flash[:danger] = t ".messages.not_found"
    redirect_to root_url
  end
end
