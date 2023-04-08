# frozen_string_literal: true

class Public::SessionsController < Devise::SessionsController
   # before_action :configure_sign_in_params, only: [:create]

  protected
    def reject_member
      @member = Member.find_by(email: params[:member][:email])
      if @member
        if @member.valid_password?(params[:member][:password]) && (@member.is_deleted == false)
          flash[:notice] = "退会済みの為、再登録が必要です。"
          redirect_to new_member_session_path
        end
      end
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
end
