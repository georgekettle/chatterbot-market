class Dashboard::ConversationsController < ApplicationController
  # GET /dashboard/chatbots/:chatbot_id/conversations
  def index
    @chatbot = Chatbot.find(params[:chatbot_id])
    @pagy, @conversations = pagy(
      policy_scope(@chatbot.conversations).order(created_at: :desc)
    )

    breadcrumb "Dashboard", dashboard_chatbots_path
    breadcrumb @chatbot.name.capitalize, request.path
  end
end
