class Public::PostimagesController < ApplicationController
  def new
    @postimage = Postimage.new
  end

  def index
    @postimages = Postimage.all
  end

  def create
    @postimage = Postimage.new(book_params)
    @postimage.user_id = current_user.id
    if @postimage.save
      redirect_to postimage_path(@postimage), notice:  "You have created book successfully."
    else
      @postimages = Postimage.all
      render 'index'
    end
  end

  def edit
    @postimage = Postimage.new(book_params)
  end

  def show
    @postimage = Postimage.find(params[:id])
    @postimage_comment = Comment.new
  end

  def update
    @postimage = Postimage.find(params[:id])
    if @postimage.update(postimage_params)
      redirect_to postimage_path(@postimage), notice: "You have updated book successfully."
    else
      render "edit"
    end
  end

  def destroy
    @postimage = Postimage.find(params[:id])
    @postimage.destroy
    redirect_to postimages_path
  end

  private

  def postimage_params
    params.require(:postimage).permit(:title, :body, :image)
  end

  def is_matching_login_user
    postimage = Postimage.find(params[:id])
    if(postimage.user_id != current_user.id)
      redirect_to postimages_path
    end
  end

end
