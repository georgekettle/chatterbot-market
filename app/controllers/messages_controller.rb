class MessagesController < ApplicationController
  # POST /chats/:chat_id/messages
  def create
    @chat = Chat.find(params[:chat_id])
    @message = Message.new(message_params.merge(chat: @chat, role: "user"))
    authorize @message

    respond_to do |format|
      if @message.save
        GetAiResponseJob.perform_later(@chat)
        format.turbo_stream
        format.html { redirect_to chat_path(@chat) }
      else
        format.turbo_stream { render turbo_stream: turbo_stream.replace(dom_id(@chat, :message_form), partial: "messages/form", locals: { chat: @chat, message: @message }) }
        format.html { render "chats/show" }
      end
    end
  end

  private

  def message_params
    params.require(:message).permit(:content)
  end
end
