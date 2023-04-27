module HistoryTracker
  extend ActiveSupport::Concern

  included do |base|
    before_action :update_history
  end

  private

  def update_history
    if request.get? && !['new', 'edit'].include?(params[:action])
      session[:history] ||= []
      # only add if request.fullpath is not already first in the array
      session[:history].unshift(request.fullpath) unless session[:history].first == request.fullpath
      # only keep the last 10 paths
      session[:history] = session[:history].first(10)
    end
  end
end