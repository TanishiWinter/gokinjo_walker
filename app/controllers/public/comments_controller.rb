class Public::CommentsController < ApplicationController
  def create
    postimage = PostImage.find(params[:post_image_id])
    comment = current_user.comments.new(comment_params)
    comment.postimage_id = postimage.id
    comment.save
    redirect_to postimage_path(postimage)
  end

  def destroy
    Comment.find(params[:id]).destroy
    redirect_to postimage_path(params[:post_image_id])
  end

  private

  def comment_params
    params.require(:comment).permit(:comment)
  end

end
