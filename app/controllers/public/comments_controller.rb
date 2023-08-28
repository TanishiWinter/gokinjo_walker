class Public::CommentsController < ApplicationController
  def create
    postimage = PostImage.find(params[:postimage_id])
    comment = current_user.comments.new(comment_params)
    comment.post_image_id = postimage.id
    comment.save
    redirect_to postimage_path(postimage)
  end

  def destroy
    Comment.find(params[:id]).destroy
    @comment = Comment.new
    redirect_to postimage_path(params[:postimage_id])
  end

  private

  def comment_params
    params.require(:comment).permit(:comment)
  end

end
