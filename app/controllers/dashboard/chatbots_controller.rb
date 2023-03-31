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
  end
end
