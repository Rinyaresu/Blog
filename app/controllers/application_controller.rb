class ApplicationController < ActionController::Base
  before_action :configure_permited_parameters, if: :devise_controller?
  before_action :set_current_user, if: :user_signed_in?

  protected

  def configure_permited_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:username])
    devise_parameter_sanitizer.permit(:account_update, keys: [:username])
  end

  private

  def set_current_user
    Current.user = current_user
  end
end
