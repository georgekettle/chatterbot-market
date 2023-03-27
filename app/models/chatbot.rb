class Chatbot < ApplicationRecord
  belongs_to :account
  has_many :conversations, dependent: :destroy

  validates :name, presence: true, length: { minimum: 3 }
end
