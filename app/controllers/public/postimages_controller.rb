class Public::PostimagesController < ApplicationController

  before_action :is_matching_login_postimage, only: [:update, :edit]
  before_action :set_cache_headers

  def new
    @postimage = PostImage.new
  end

  def index
    @postimages = PostImage.where.not(is_active: false).order(created_at: :desc).page(params[:page])
  end

  def create
    @postimage = PostImage.new(post_image_params)
    @postimage.user_id = current_user.id
    if @postimage.save
      redirect_to postimage_path(@postimage), notice:  "投稿に成功しました"
    else
      @postimages = PostImage.page(params[:page])
      render 'new'
    end
  end

  def edit
    begin
      is_matching_login_postimage
      @postimage = PostImage.find(params[:id])
    rescue
      flash[:alert] = '情報の取得に失敗。一覧画面に遷移します'
      redirect_to postimages_path
    end
  end

  def show

    begin
      @postimage = PostImage.find(params[:id])
      @postimage_comment = Comment.new
      @postimage_comments = @postimage.comments.page(params[:page])
      gon.studio = @postimage #google map用
    rescue
      flash[:alert] = '情報の取得に失敗。一覧画面に遷移します'
      redirect_to postimages_path
    end

  end

  def update
    is_matching_login_postimage
    @postimage = PostImage.find(params[:id])
    if @postimage.update(post_image_params)
      redirect_to postimage_path(@postimage), notice: "編集に成功しました"
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

  def set_cache_headers
    response.headers['Cache-Control'] = 'no-cache, no-store, max-age=0, must-revalidate'
    response.headers['Pragma'] = 'no-cache'
    response.headers['Expires'] = 'Fri, 01 Jan 1990 00:00:00 GMT'
  end

  def post_image_params
    params.require(:post_image).permit(:title, :body, :address, :is_active, :image, :latitude, :longitude)
  end


  def is_matching_login_postimage
    postimage = PostImage.find(params[:id])
    if(postimage.user_id != current_user.id)
      redirect_to postimages_path
    end
  end



end
