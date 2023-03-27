class Chatbot < ApplicationRecord
  belongs_to :account

  validates :name, presence: true, length: { minimum: 3 }
end
