class TrainingMaterial < ApplicationRecord
  belongs_to :material, polymorphic: true, dependent: :destroy
  belongs_to :chatbot
  has_one :account, through: :chatbot
end
