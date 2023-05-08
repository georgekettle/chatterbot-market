class Chatbot < ApplicationRecord
  STATUS_DESCRIPTIONS = {
    draft: "Your chatbot will be accessible only to you",
    published: "Your chatbot will be accessible to anyone with the link",
    marketplace: "Your chatbot will be published on the marketplace and accessible to anyone"
  }

  belongs_to :account
  belongs_to :base_model
  has_many :conversations, dependent: :destroy
  has_many :messages, through: :conversations
  has_many :feedback, through: :messages
  has_many :training_materials, dependent: :destroy

  validates :name, presence: true, length: { minimum: 3 }
  validates :description, presence: true, length: { minimum: 10 }

  enum status: { draft: 0, published: 1, marketplace: 2 }
end
