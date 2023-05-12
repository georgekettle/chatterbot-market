class Message < ApplicationRecord
  include ActionView::RecordIdentifier

  belongs_to :chat
  has_one :chatbot, through: :chat
  has_one :creator, through: :chat, class_name: "User", source: :creator
  has_one :feedback, dependent: :destroy

  enum role: { system: 0, assistant: 1, user: 2 }

  validates :content, presence: true

  after_create_commit -> { broadcast_created }
  after_update_commit -> { broadcast_updated }

  def broadcast_created
    broadcast_append_to(
      dom_id(chat, :messages),
      partial: "messages/message",
      locals: { message: self },
      target: dom_id(chat, :messages)
    )
  end

  def broadcast_updated
    broadcast_append_to(
      dom_id(chat, :messages),
      partial: "messages/message",
      locals: { message: self },
      target: dom_id(chat, :messages)
    )
  end
end
