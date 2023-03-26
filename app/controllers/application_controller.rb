class ApplicationController < ActionController::Base
  include SetCurrentRequestDetails
  include Users::TimeZone

  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :authenticate_user!

  protected

  # To add extra fields to Devise registration, add the attribute names to `extra_keys`
  def configure_permitted_parameters
    extra_keys = [:name, :time_zone]
    signup_keys = extra_keys + []
    devise_parameter_sanitizer.permit(:sign_up, keys: signup_keys)
    devise_parameter_sanitizer.permit(:account_update, keys: extra_keys)
    devise_parameter_sanitizer.permit(:accept_invitation, keys: extra_keys)
  end
end
