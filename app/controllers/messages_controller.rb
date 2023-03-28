class MessagesController < ApplicationController
  # POST /conversations/:conversation_id/messages
  def create
    @conversation = Conversation.find(params[:conversation_id])
    @message = @conversation.messages.new(message_params)
    @message.sender = current_user
    authorize @message

    respond_to do |format|
      if @message.save
        format.turbo_stream
        format.html { redirect_to conversation_path(@conversation) }
      else
        format.turbo_stream { render turbo_stream: turbo_stream.replace(dom_id(@conversation, :message_form), partial: "messages/form", locals: { conversation: @conversation, message: @message }) }
        format.html { render "conversations/show" }
      end
    end
  end

  private

  def message_params
    params.require(:message).permit(:content)
  end
end
