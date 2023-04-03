class ConversationsController < ApplicationController
  layout 'without_navbar', only: %i[ show new create ]
  
  before_action :set_conversation, only: %i[ show ]
  
  # GET /conversations/1
  def show
    @chatbot = @conversation.chatbot
    @messages = @conversation.messages.includes(:sender, :feedback, :chatbot).order(created_at: :asc)
    @message = Message.new
  end

  # GET /chatbots/:chatbot_id/conversations/new
  def new
    @chatbot = Chatbot.find(params[:chatbot_id])
    @conversation = Conversation.new
    @conversation.chatbot = @chatbot
    @conversation.creator = current_user
    @conversation.messages.build
    authorize @conversation
  end

  # POST /chatbots/:chatbot_id/conversations
  def create
    # Accepts nested attributes for messages
    @conversation = Conversation.new(conversation_params)
    # Add sender to messages
    @conversation.messages.each do |message|
      message.sender = current_user
    end
    @chatbot = Chatbot.find(params[:chatbot_id])
    @conversation.chatbot = @chatbot
    @conversation.creator = current_user
    authorize @conversation
    if @conversation.save
      redirect_to conversation_path(@conversation), status: :see_other
    else
      render :new, status: :unprocessable_entity
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_conversation
      @conversation = Conversation.find(params[:id])
      authorize @conversation
    end

    # Only allow a list of trusted parameters through.
    def conversation_params
      params.require(:conversation).permit(:title, messages_attributes: [:content])
    end
end
