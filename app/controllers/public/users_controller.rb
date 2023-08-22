class Public::UsersController < ApplicationController

  before_action :ensure_correct_user, only: [:update, :edit]
  before_action :set_user, only: [:favorites]

  def follows
    user = User.find(params[:id])
    @users = user.following_users.page(params[:page]).order(created_at: :desc)
  end

  # フォロワー一覧
  def followers
    user = User.find(params[:id])
    @users = user.follower_users.page(params[:page]).order(created_at: :desc)
  end

  def index
    @users = User.page(params[:page]).order(created_at: :desc)
  end

  def show
    @user = User.find(params[:id])
    @postimages = @user.post_images.order(created_at: :desc).page(params[:page])
    #詳細画面で非表示の投稿を投稿者にだけ表示にする
    @postimages_notactive = @user.post_images.where.not(is_active: false).order(created_at: :desc).page(params[:page])
    @following_users = @user.following_users
    @follower_users = @user.follower_users
  end

  def edit
    ensure_correct_user
    @user = User.find(params[:id])
  end

  def update
    ensure_correct_user
    @user = User.find(params[:id])
    if @user.update(user_params)
      redirect_to user_path(@user.id), notice: "編集に成功しました"
    else
      render :edit
    end
  end

  def withdraw
    user = User.find(current_user.id)
    user.update(is_deleted: true)
    reset_session
    flash[:notice] = "正常に退会いたしました"
    redirect_to root_path
  end

  def favorites
    favorites = Favorite.where(user_id: @user.id).pluck(:post_image_id)
    @favorite_postimages = PostImage.find(favorites)
  end

  private

  def user_params
    params.require(:user).permit(:name, :introduction, :profile_image,:is_deleted)
  end

  def set_user
    @user = User.find(params[:id])
  end

  def ensure_correct_user
    @user = User.find(params[:id])
    unless @user == current_user
      redirect_to user_path(current_user) and return
    end
    if @user.email == "guest@example.com"
      redirect_to user_path(current_user) , notice: "ゲストユーザーはプロフィール編集画面へ遷移できません。"
    end
  end

end
