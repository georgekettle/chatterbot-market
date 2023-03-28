class Conversation < ApplicationRecord
  belongs_to :chatbot
  belongs_to :account, optional: true
end
