class ChatsController < ApplicationController
  layout 'without_navbar', only: %i[ show new create ]
  
  before_action :set_chat, only: %i[ show ]
  
  # GET /chats/1
  def show
    @chatbot = @chat.chatbot
    @messages = @chat.messages.includes(:sender, :feedback, :chatbot).order(created_at: :asc)
    @message = Message.new
  end

  # GET /chatbots/:chatbot_id/chats/new
  def new
    @chatbot = Chatbot.find(params[:chatbot_id])
    @chat = Chat.new
    @chat.chatbot = @chatbot
    @chat.creator = current_user
    @chat.messages.build
    authorize @chat
  end

  # POST /chatbots/:chatbot_id/chats
  def create
    # Accepts nested attributes for messages
    @chat = Chat.new(chat_params)
    # Add sender to messages
    @chat.messages.each do |message|
      message.sender = current_user
    end
    @chatbot = Chatbot.find(params[:chatbot_id])
    @chat.chatbot = @chatbot
    @chat.creator = current_user
    authorize @chat
    if @chat.save
      redirect_to chat_path(@chat), status: :see_other
    else
      render :new, status: :unprocessable_entity
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_chat
      @chat = Chat.find(params[:id])
      authorize @chat
    end

    # Only allow a list of trusted parameters through.
    def chat_params
      params.require(:chat).permit(:title, messages_attributes: [:content])
    end
end
