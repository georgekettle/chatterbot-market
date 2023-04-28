class BaseModel < ApplicationRecord
  has_many :chatbots, dependent: :nullify

  validates :name, presence: true
  validates :company, presence: true
end
