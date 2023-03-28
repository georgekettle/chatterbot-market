class ApplicationController < ActionController::Base
  include SetCurrentRequestDetails
  include Users::TimeZone
  include CurrentHelper
  include Authorization
  include ActionView::RecordIdentifier # for dom_id
  include Pagy::Backend
  Pagy::DEFAULT[:items] = 20 # default items per page
  Pagy::DEFAULT[:size] = [1, 2, 2, 1] # default page size array

  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :authenticate_user!

  after_action :verify_authorized, except: :index, unless: :devise_controller?
  after_action :verify_policy_scoped, only: :index, unless: :devise_controller?

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
