class ApplicationController < ActionController::Base
	before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :authenticate_user!

  protect_from_forgery with: :exception
  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up) { |u| u.permit(:user_name, :email, :password, :password_confirmation, :remember_me, :avatar, :avatar_cache) }
    devise_parameter_sanitizer.permit(:sign_in) { |u| u.permit(:email, :password, :remember_me) }
    devise_parameter_sanitizer.permit(:account_update) { |u| u.permit(:user_name, :email, :password, :password_confirmation, :current_password, :avatar) }
  end

end
