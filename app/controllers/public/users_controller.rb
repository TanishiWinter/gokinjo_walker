class Public::UsersController < ApplicationController

  before_action :ensure_correct_user, only: [:update, :edit]

  def follows
    user = User.find(params[:id])
    @users = user.following_user.page(params[:page]).per(3).reverse_order
  end

  def followers
    user = User.find(params[:id])
    @users = user.follower_user.page(params[:page]).per(3).reverse_order
  end

  def index
  end

  def show
    @user = User.find(params[:id])
    @postimages = @user.post_images
    @following_users = @user.following_user
    @follower_users = @user.follower_user

  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      redirect_to user_path(@user.id), notice: "You have updated user successfully."
    else
      render :edit
    end
  end

  def withdraw
    user = user.find(current_customer.id)
    user.update(is_deleted: true)
    reset_session
    flash[:notice] = "正常に退会いたしました"
    redirect_to root_path
  end

  private

  def user_params
    params.require(:user).permit(:name, :profile_image,:is_deleted)
  end

  def ensure_correct_user
    @user = User.find(params[:id])
    unless @user == current_user
      redirect_to user_path(current_user)
    end
  end

end
