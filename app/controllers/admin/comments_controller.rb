class Admin::CommentsController < ApplicationController

  def destroy
    Comment.find(params[:id]).destroy
    redirect_to admin_postimage_path(params[:postimage_id])
  end

  private

  def comment_params
    params.require(:comment).permit(:comment)
  end

end
