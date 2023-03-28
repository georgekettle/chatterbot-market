class Message < ApplicationRecord
  belongs_to :conversation
  belongs_to :account
  belongs_to :sender, class_name: "User", optional: true
  has_one :chatbot, through: :conversation

  validates :content, presence: true, length: { maximum: 1000 }
end
