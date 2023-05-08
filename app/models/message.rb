class Message < ApplicationRecord
  belongs_to :conversation
  belongs_to :sender, class_name: "User", optional: true
  has_one :chatbot, through: :conversation
  has_one :feedback, dependent: :destroy

  validates :content, presence: true

  enum role: { system: 0, assistant: 1, user: 2 }

  # Method to check if message from owner
  def sent_by_account?(account)
    account.users.include?(sender)
  end

  # Method to find previous message from conversation
  def previous_message
    conversation.messages.where("id < ?", id).last
  end
end
