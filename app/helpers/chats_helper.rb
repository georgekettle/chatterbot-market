module ChatsHelper
  def chat_path_for_side_nav
    if @chat
      new_chat_path(chatbot_id: @chat.chatbot_id)
    elsif params[:chatbot_id]
      new_chat_path(chatbot_id: params[:chatbot_id])
    else
      new_chat_path
    end
  end
end