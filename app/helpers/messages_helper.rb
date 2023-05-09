module MessagesHelper
  def message_sender(message)
    message.user? ? message.creator.name : message.chatbot.name
  end
end
