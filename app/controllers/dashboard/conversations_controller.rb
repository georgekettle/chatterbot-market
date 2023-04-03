class Dashboard::ConversationsController < ApplicationController
  layout 'dashboard'

  # GET /dashboard/chatbots/:chatbot_id/conversations
  def index
    @chatbot = Chatbot.find(params[:chatbot_id])
    # @conversations = policy_scope(@chatbot.conversations).order(created_at: :desc)
    # @conversations = pagy(@conversations, 20)
    @pagy, @conversations = pagy(
      policy_scope(@chatbot.conversations).order(created_at: :desc)
    )

    breadcrumb "Dashboard", dashboard_chatbots_path
    breadcrumb @chatbot.name.capitalize, request.path
  end
end
