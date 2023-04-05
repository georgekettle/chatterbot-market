class Dashboard::ChatbotsController < ApplicationController
  layout 'dashboard'
  
  # GET /dashboard/chatbots
  def index
    @chatbots = policy_scope(Chatbot).where(account: current_account)
  end

  # GET /dashboard/chatbots/1
  def show
    @chatbot = Chatbot.find(params[:id])
    @conversations = @chatbot.conversations.where("created_at > ?", 7.days.ago).order(created_at: :desc).first(5)
    authorize @chatbot
    set_breadcrumbs
  end

  # GET /dashboard/chatbots/1/settings
  def settings
    @chatbot = Chatbot.find(params[:id])
    authorize @chatbot, :update?
    set_breadcrumbs
  end

  private

  def set_breadcrumbs
    breadcrumb "Dashboard", dashboard_chatbots_path
    breadcrumb @chatbot.name.capitalize, request.path
  end
end
