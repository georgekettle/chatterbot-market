class Conversation < ApplicationRecord
  belongs_to :chatbot
  belongs_to :creator, class_name: "User"
  has_many :messages, dependent: :destroy

  accepts_nested_attributes_for :messages
end
