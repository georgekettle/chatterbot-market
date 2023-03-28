class ConversationsController < ApplicationController
  layout 'without_navbar', only: %i[ show ]
  
  before_action :set_conversation, only: %i[ show ]
  
  # GET /conversations/1
  def show
    @chatbot = @conversation.chatbot
  end

  # GET /chatbots/:chatbot_id/conversations
  def index
    @chatbot = Chatbot.find(params[:chatbot_id])
    # @conversations = policy_scope(@chatbot.conversations).order(created_at: :desc)
    # @conversations = pagy(@conversations, 20)
    @pagy, @conversations = pagy(
      policy_scope(@chatbot.conversations).order(created_at: :desc)
    )
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_conversation
      @conversation = Conversation.find(params[:id])
      authorize @conversation
    end
end
