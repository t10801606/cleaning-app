class CommentsController < ApplicationController
  def create
    @comment = Comment.new(comment_params)
    if @comment.save
      redirect_to desk_path(@comment.desk)
    else
      @desk = @comment.desk
      @comments = @desk.comments
      render 'desks/show'
    end
  end

  private

  def comment_params
    params.require(:comment).permit(:text).merge(user_id: current_user.id, desk_id: params[:desk_id])
  end
end
