class Dashboard::ConversationsController < ApplicationController
  layout 'dashboard_chatbot', only: [:index, :new]

  before_action :set_chatbot, only: [:index, :new, :create]
  before_action :set_conversations, only: [:index, :new]

  # GET /dashboard/chatbots/:chatbot_id/conversations
  def index
    @selected_conversation = params[:conversation_id].present? ? Conversation.find(params[:conversation_id]) : @conversations.first
    breadcrumb "My Chatbots", dashboard_chatbots_path
    breadcrumb @chatbot.name.capitalize, request.path
  end

  # GET /dashboard/chatbots/:chatbot_id/conversations/new
  def new
    @conversation = Conversation.new
    @conversation.messages.build
    authorize @conversation
    breadcrumb "My Chatbots", dashboard_chatbots_path
    breadcrumb @chatbot.name.capitalize, request.path
  end

  # POST /dashboard/chatbots/:chatbot_id/conversations
  def create
    # Accepts nested attributes for messages
    @conversation = Conversation.new(conversation_params)
    # Add sender to messages
    @conversation.messages.each do |message|
      message.sender = current_user
    end
    @conversation.chatbot = @chatbot
    @conversation.creator = current_user
    authorize @conversation
    if @conversation.save
      redirect_to dashboard_chatbot_conversations_path(@chatbot), status: :see_other
    else
      render :new, status: :unprocessable_entity
    end
  end

  private

  def set_chatbot
    @chatbot = Chatbot.find(params[:chatbot_id])
  end

  def set_conversations
    @pagy, @conversations = pagy(
      policy_scope(@chatbot.conversations).order(created_at: :desc)
    )
  end

   # Only allow a list of trusted parameters through.
   def conversation_params
    params.require(:conversation).permit(:title, messages_attributes: [:content])
  end
end
