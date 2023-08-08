class Public::SearchesController < ApplicationController

  before_action :authenticate_user!

  def search
    @word = params[:word]
    @postimage_address = PostImage.where('address LIKE ?', "%#{@word}%")
  end

end
