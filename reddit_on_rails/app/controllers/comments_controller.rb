class CommentsController < ApplicationController
  def new
    @comment = Comment.new(post_id: params[:post_id])
    render :new
  end
  
  def create
    @comment = Comment.new(comment_params)
    @comment.user_id = current_user.id
    if @comment.save
      redirect_to post_url(@comment.post_id)
    else
      flash.now[:errors] = @comment.errors.full_messages
      render :new
    end
  end
  
  private
  def comment_params
    params.require(:comment).permit(:content, :post_id)
  end
end