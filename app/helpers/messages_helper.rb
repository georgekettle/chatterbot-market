module MessagesHelper
  def message_timestamp(message, time_zone = nil)
    message.created_at.in_time_zone(time_zone).strftime('%l:%M %p').sub(' AM ', ' am ').sub(' PM ', ' pm ')
  end

  def message_sender(message)
    message.user? ? message.creator.name : message.chatbot.name
  end
end
