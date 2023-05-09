class Feedback < ApplicationRecord
  belongs_to :message
  belongs_to :user
  has_one :chat, through: :message
  has_one :chatbot, through: :chat

  enum rating: { negative: 0, positive: 1 }

  validate :created_by_chat_creator
  validates :rating, presence: true

  private

  def created_by_chat_creator
    errors.add(:user, "must be the chat creator") unless message.chat.creator == user
  end
end
