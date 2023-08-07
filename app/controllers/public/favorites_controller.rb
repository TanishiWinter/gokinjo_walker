class Public::FavoritesController < ApplicationController

  def create
    post_image = PostImage.find(params[:postimage_id])
    favorite = current_user.favorites.new(post_image_id: post_image.id)
    favorite.save
    redirect_to postimages_path
  end

  def destroy
    post_image = PostImage.find(params[:postimage_id])
    favorite = current_user.favorites.find_by(post_image_id: post_image.id)
    favorite.destroy
    redirect_to postimages_path
  end

end
