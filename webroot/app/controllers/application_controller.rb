class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  
  before_filter :configure_permitted_parameters, if: :devise_controller?
  before_action :user_signed_in?
                :current_user
                :user_session
                
protected

def configure_permitted_parameters
  devise_parameter_sanitizer.for(:sign_up) { |u| u.permit(:username, :email, :password, :password_confirmation, :remember) }
end

#def configure_permitted_parameters
#    devise_parameter_sanitizer.for(:sign_up) << :username
#  end
end