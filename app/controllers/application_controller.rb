class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?

    #def after_sign_in_path_for(resource)
     # member_path(current_member,@member)
    #end


  def after_sign_out_path_for(resource_or_scope)
    if resource_or_scope == :public
       root_path
    elsif resource_or_scope == :admin
       new_admin_session_path
    else
       root_path
    end
  end

  private

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name]) # 新規登録時(sign_up時)にnameというキーのパラメーターを追加で許可する
  end

end
