class Message < ApplicationRecord
  belongs_to :conversation
  belongs_to :account

  validates :content, presence: true, length: { maximum: 1000 }
end
