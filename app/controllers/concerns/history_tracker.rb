module HistoryTracker
  extend ActiveSupport::Concern

  included do |base|
    before_action :update_history
  end

  private

  def update_history
    if request.get? && !['new', 'edit'].include?(params[:action])
      session[:history] ||= []
      session[:history].unshift(request.fullpath)
      session[:history].pop if session[:history].length > 10
    end
  end
end