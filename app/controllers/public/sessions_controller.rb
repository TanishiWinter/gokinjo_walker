# frozen_string_literal: true

class Public::SessionsController < Devise::SessionsController
  # before_action :configure_sign_in_params, only: [:create]
  before_action :reject_invalid_user, only: [:create]

  def after_sign_in_path_for(resource)
    postimages_path
  end

  # GET /resource/sign_in
  # def new
  #   super
  # end

  # POST /resource/sign_in
  # def create
  #   super
  # end

  # DELETE /resource/sign_out
  # def destroy
  #   super
  # end

  # protected

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_sign_in_params
  #   devise_parameter_sanitizer.permit(:sign_in, keys: [:attribute])
  # end

  def reject_invalid_user
    user = User.find_by(email: params[:user][:email])
    # ユーザー情報が存在する場合
    if user
      if user.valid_password?(params[:user][:password]) && (user.is_deleted == true )
        flash[:notice] = "退会済みです。再度ご登録をしてご利用ください"
        redirect_to new_user_registration_path
      else
        flash[:notice] = "入力情報が正しくありません"
      end
    else
      flash[:notice] = "該当するユーザーが見つかりません"
    end
  end

end
