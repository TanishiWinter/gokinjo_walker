class Admin::PostimagesController < ApplicationController

  before_action :authenticate_admin!

  def index
    @postimages = PostImage.page(params[:page])
  end

  def show
    @postimage = PostImage.find(params[:id])
  end

  def edit
    @postimage = PostImage.find(params[:id])
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

end
