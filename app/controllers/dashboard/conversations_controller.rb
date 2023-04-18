class Dashboard::ConversationsController < ApplicationController
  layout 'dashboard_chatbot', only: :index

  # GET /dashboard/chatbots/:chatbot_id/conversations
  def index
    @chatbot = Chatbot.find(params[:chatbot_id])
    @pagy, @conversations = pagy(
      policy_scope(@chatbot.conversations).order(created_at: :desc)
    )
    @selected_conversation = params[:conversation_id].present? ? Conversation.find(params[:conversation_id]) : @conversations.first

    breadcrumb "My Chatbots", dashboard_chatbots_path
    breadcrumb @chatbot.name.capitalize, request.path
  end
end
