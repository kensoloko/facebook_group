class CommentsController < ApplicationController
  def create
    @comment = if params[:comment][:parent_id].to_i > 0
                find_comment_parent
              else
                 Comment.new comment_params
              end

    if comment.save
      flash.now[:success] = "Create comment success"
      @post = comment.post
      respond_to do |format|
        format.html{redirect_to :back}
        format.js
      end
    else
      flash[:danger] = "Create comment failed"
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
      flash[:danger] = t ".comments.messages.not found"
      redirect_to :back
    end
  end
end
