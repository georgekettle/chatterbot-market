class Chat < ApplicationRecord
  belongs_to :chatbot
  belongs_to :creator, class_name: "User"
  has_many :messages, -> { order(:created_at) }, dependent: :destroy

  accepts_nested_attributes_for :messages

  def messages_for_openai
    mapped = messages.map { |message| { role: message.role, content: message.content } }
    mapped.unshift({ role: "system", content: chatbot.system_prompt })
  end
end
