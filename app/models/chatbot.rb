class Chatbot < ApplicationRecord
  belongs_to :account
  has_many :conversations, dependent: :destroy
  has_many :messages, through: :conversations
  has_many :feedback, through: :messages
  has_many :training_materials, dependent: :destroy
  has_many :csv_fine_tunes, through: :training_materials

  validates :name, presence: true, length: { minimum: 3 }
  validates :description, presence: true, length: { minimum: 10 }

  enum status: { draft: 0, live: 1 }
end
