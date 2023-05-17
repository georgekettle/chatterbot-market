class StaticController < ApplicationController
  skip_before_action :authenticate_user!
  skip_after_action :verify_authorized

  def you_must_sign_in
  end
end
