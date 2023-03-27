class ConversationsController < ApplicationController
  layout 'without_navbar'
  
  before_action :set_conversation, only: %i[ show ]
  
  # GET /conversations/1
  def show
    @chatbot = @conversation.chatbot
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_conversation
      @conversation = Conversation.find(params[:id])
      authorize @conversation
    end
end
