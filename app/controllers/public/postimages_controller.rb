class Public::PostimagesController < ApplicationController

  def new
    @postimage = PostImage.new
  end

  def index
    @postimages = PostImage.page(params[:page])
  end

  def create
    @postimage = PostImage.new(post_image_params)
    @postimage.user_id = current_user.id
    if @postimage.save
      redirect_to postimage_path(@postimage), notice:  "You have created book successfully."
    else
      @postimages = PostImage.page(params[:page])
      render 'index'
    end
  end

  def edit
    @postimage = PostImage.find(params[:id])
  end

  def show
    @postimage = PostImage.find(params[:id])
    @postimage_comment = Comment.new
    gon.studio = @postimage #google map用
  end

  def update
    @postimage = PostImage.find(params[:id])
    if @postimage.update(post_image_params)
      redirect_to postimage_path(@postimage), notice: "You have updated book successfully."
    else
      render "edit"
    end
  end

  def destroy
    @postimage = PostImage.find(params[:id])
    @postimage.delete
    redirect_to postimages_path
  end

  private

  def post_image_params
    params.require(:post_image).permit(:title, :body, :address, :image)
  end

  def is_matching_login_user
    postimage = PostImage.find(params[:id])
    if(postimage.user_id != current_user.id)
      redirect_to postimages_path
    end
  end

end
