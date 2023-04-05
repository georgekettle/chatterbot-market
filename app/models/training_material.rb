class TrainingMaterial < ApplicationRecord
  has_one :material, polymorphic: true, dependent: :destroy
  belongs_to :chatbot
end
