class Public::PostimagesController < ApplicationController
  def new
    @postimage = PostImage.new
  end

  def index
    @postimages = PostImage.all
  end

  def create
    @postimage = PostImage.new(book_params)
    @postimage.user_id = current_user.id
    if @postimage.save
      redirect_to postimage_path(@postimage), notice:  "You have created book successfully."
    else
      @postimages = PostImage.all
      render 'index'
    end
  end

  def edit
    @postimage = PostImage.new(book_params)
  end

  def show
    @postimage = PostImage.find(params[:id])
    @postimage_comment = Comment.new
  end

  def update
    @postimage = PostImage.find(params[:id])
    if @postimage.update(postimage_params)
      redirect_to postimage_path(@postimage), notice: "You have updated book successfully."
    else
      render "edit"
    end
  end

  def destroy
    @postimage = PostImage.find(params[:id])
    @postimage.destroy
    redirect_to postimages_path
  end

  private

  def postimage_params
    params.require(:postimage).permit(:title, :body, :image)
  end

  def is_matching_login_user
    postimage = PostImage.find(params[:id])
    if(postimage.user_id != current_user.id)
      redirect_to postimages_path
    end
  end

end
