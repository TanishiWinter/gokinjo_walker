class Admin::PostimagesController < ApplicationController

  before_action :authenticate_admin!

  def index
    @postimages = PostImage.page(params[:page]).order(created_at: :desc)
  end

  def show
    begin
      @postimage = PostImage.find(params[:id])
      @postimage_comment = Comment.new
      gon.studio = @postimage #google map用
    rescue
      flash[:alert] = '情報の取得に失敗。一覧画面に遷移します'
      redirect_to admin_postimages_path
    end
  end

  def edit
    @postimage = PostImage.find(params[:id])
  end

  def update
    @postimage = PostImage.find(params[:id])
    if @postimage.update(post_image_params)
      redirect_to admin_postimage_path(@postimage), notice: "変更を保存しました"
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
