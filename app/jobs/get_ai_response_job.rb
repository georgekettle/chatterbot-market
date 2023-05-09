class GetAiResponseJob < ApplicationJob
  queue_as :default

  def perform(chat)
    call_openai(chat: chat)
  end

  private

  def call_openai(chat:)
    message = chat.messages.create(role: "assistant", content: "")

    OpenAI::Client.new.chat(
      parameters: {
        model: chat.chatbot.base_model.name,
        messages: chat.messages_for_openai,
        temperature: 0.1,
        stream: stream_proc(message: message)
      }
    )
  end

  def stream_proc(message:)
    proc do |chunk, _bytesize|
      new_content = chunk.dig("choices", 0, "delta", "content")
      message.update(content: message.content + new_content) if new_content
    end
  end
end
