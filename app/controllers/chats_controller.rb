class ChatsController < ApplicationController
  layout 'chat', only: %i[ show new create ]

  before_action :set_chat, only: %i[ show ]
  before_action :set_chatbot, only: %i[ new create ]
  before_action :set_chat_history, only: %i[ show new create ]
  
  # GET /chats/1
  def show
    @chatbot = @chat.chatbot
    @messages = @chat.messages.includes(:sender, :feedback, :chatbot).order(created_at: :asc)
    @message = Message.new
  end

  # GET /chats/new?chatbot_id=1
  def new
    @chat = Chat.new
    @chat.chatbot = @chatbot
    @chat.creator = current_user
    @chat.messages.build
    @favorited_chatbots = current_user.favorited_by_type('Chatbot')
    
    authorize @chat
  end

  def create
    @chat = Chat.new(chat_params.merge(chatbot: @chatbot, creator: current_user))
    @chat.messages.each { |message| message.role = "user" }
    authorize @chat
    if @chat.save
      GetAiResponseJob.perform_later(@chat)
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

    def set_chatbot
      @chatbot = Chatbot.find_by(id: params[:chatbot_id]) || Chatbot.default || Chatbot.first
    end

    # Only allow a list of trusted parameters through.
    def chat_params
      params.require(:chat).permit(:title, messages_attributes: [:content])
    end

    def set_chat_history
      # find all chats that the user has participated in ordered by latest messages
      @chat_history = Chat.joins(:messages).where(creator: current_user).order('messages.created_at DESC').uniq
    end
end
