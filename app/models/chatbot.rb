class Chatbot < ApplicationRecord
  belongs_to :account
  has_many :conversations, dependent: :destroy
  has_many :messages, through: :conversations
  has_many :feedback, through: :messages
  has_many :training_materials, dependent: :destroy

  validates :name, presence: true, length: { minimum: 3 }

  enum status: { draft: 0, live: 1 }
end
