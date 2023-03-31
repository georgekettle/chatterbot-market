class Feedback < ApplicationRecord
  belongs_to :message
  belongs_to :user

  enum rating: { negative: 0, positive: 1 }

  validate :created_by_conversation_creator
  validates :rating, presence: true

  private

  def created_by_conversation_creator
    errors.add(:user, "must be the conversation creator") unless message.conversation.creator == user
  end
end
