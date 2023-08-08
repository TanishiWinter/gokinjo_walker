class Public::SearchesController < ApplicationController

  before_action :authenticate_user!

  def search
    @range = params[:range]
    @word = params[:word]

    if @range == "User"
      @users = User.where('name LIKE ?', "%#{@word}%")
    else
      @postimage_address = PostImage.where('address LIKE ?', "%#{@word}%")
    end

  end

end
