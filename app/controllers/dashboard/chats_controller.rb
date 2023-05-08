class Dashboard::ChatsController < ApplicationController
  layout 'dashboard_chatbot', only: [:index, :new, :create]

  before_action :set_chatbot, only: [:index, :new, :create]
  before_action :set_chats, only: [:index, :new, :create]

  # GET /dashboard/chatbots/:chatbot_id/chats
  def index
    @selected_chat = params[:chat_id].present? ? Chat.find(params[:chat_id]) : @chats.first
    breadcrumb "My Chatbots", dashboard_chatbots_path
    breadcrumb @chatbot.name.capitalize, request.path
  end

  # GET /dashboard/chatbots/:chatbot_id/chats/new
  def new
    @chat = Chat.new
    @chat.messages.build
    authorize @chat
    breadcrumb "My Chatbots", dashboard_chatbots_path
    breadcrumb @chatbot.name.capitalize, request.path
  end

  # POST /dashboard/chatbots/:chatbot_id/chats
  def create
    # Accepts nested attributes for messages
    @chat = Chat.new(chat_params)
    # Add sender to messages
    @chat.messages.each do |message|
      message.sender = current_user
    end
    @chat.chatbot = @chatbot
    @chat.creator = current_user
    authorize @chat
    if @chat.save
      redirect_to dashboard_chatbot_chats_path(@chatbot), status: :see_other
    else
      render :new, status: :unprocessable_entity
    end
  end

  private

  def set_chatbot
    @chatbot = Chatbot.find(params[:chatbot_id])
  end

  def set_chats
    @pagy, @chats = pagy(
      policy_scope(@chatbot.chats).order(created_at: :desc)
    )
  end

   # Only allow a list of trusted parameters through.
   def chat_params
    params.require(:chat).permit(:title, messages_attributes: [:content])
  end
end
