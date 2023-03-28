class Conversation < ApplicationRecord
  belongs_to :chatbot
  belongs_to :account, optional: true
  has_many :messages, dependent: :destroy
end
