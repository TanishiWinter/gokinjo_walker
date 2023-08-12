class Admin::PostimagesController < ApplicationController

  before_action :authenticate_admin!

  def index
    @postimages = PostImage.page(params[:page])
  end

  def show
    begin
      @postimage = PostImage.find(params[:id])
      @postimage_comment = Comment.new
      gon.studio = @postimage #google map用
    rescue
      flash[:alert] = 'Post not found'
      redirect_to admin_postimages_path
    end
  end

  def edit
    @postimage = PostImage.find(params[:id])
  end

  def update
    @postimage = PostImage.find(params[:id])
    if @postimage.update(post_image_params)
      redirect_to admin_postimage_path(@postimage), notice: "You have updated book successfully."
    else
      render "edit"
    end
  end

  def destroy
    @postimage = PostImage.find(params[:id])
    @postimage.delete
    redirect_to admin_postimages_path
  end

  private

  def post_image_params
    params.require(:post_image).permit(:title, :body, :address, :is_active, :image, :latitude, :longitude)
  end

end
