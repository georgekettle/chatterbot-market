class Message < ApplicationRecord
  belongs_to :conversation
  belongs_to :sender, class_name: "User", optional: true
  has_one :chatbot, through: :conversation
  has_one :feedback, dependent: :destroy

  validates :content, presence: true, length: { maximum: 1000 }

  # Method to check if message from owner
  def sent_by_account?(account)
    account.users.include?(sender)
  end
end
