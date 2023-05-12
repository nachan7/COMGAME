# frozen_string_literal: true

class Public::SessionsController < Devise::SessionsController
    #before_action :configure_sign_in_params, only: [:create]
  before_action :member_state, only:[:create]

  protected

  def member_state
    @member=Member.find_by(email:params[:member][:email])
    # アカウントを取得できなかった場合、このメソッドを終了する
    return if !@member
      if @member.valid_password?(params[:member][:password]) && @member.is_deleted == true
        flash[:notice]="退会済みの為、再度会員登録してください。"
        redirect_to  new_member_registration_path
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
