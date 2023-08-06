class Public::CommentsController < ApplicationController
  def create
    postimage = PostImage.find(params[:postimage_id])
    comment = current_user.post_comments.new(comment_params)
    comment.postimage_id = postimage.id
    comment.save
    redirect_to postimage_path(post_image)
  end

  private

  def comment_params
    params.require(:post_comment).permit(:comment)
  end

end
