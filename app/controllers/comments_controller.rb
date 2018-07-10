class CommentsController < ApplicationController
  def create
    @comment = Comment.new comment_params
    if comment.save
      @post = comment.post
      respond_to do |format|
        format.html{redirect_to :back}
        format.js
      end
    else
      redirect_to root_url
    end
  end

  private

  attr_reader :comment

  def comment_params
    params.require(:comment).permit Comment::ATTRIBUTE_PARAMS
  end
end
