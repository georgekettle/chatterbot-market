class Dashboard::ChatbotsController < ApplicationController
  layout 'dashboard'
  
  def index
    @chatbots = policy_scope(Chatbot).where(account: current_account)
  end
end
