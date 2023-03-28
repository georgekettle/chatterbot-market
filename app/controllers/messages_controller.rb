class MessagesController < ApplicationController
  # POST /conversations/:conversation_id/messages
  def create
    @conversation = Conversation.find(params[:conversation_id])
    @message = @conversation.messages.new(message_params)
    @message.sender = current_user
    @message.account = current_account
    authorize @message

    if @message.save
      redirect_to conversation_path(@conversation)
    else
      render 'conversations/show', status: :unprocessable_entity
    end
  end

  private

  def message_params
    params.require(:message).permit(:content)
  end
end
