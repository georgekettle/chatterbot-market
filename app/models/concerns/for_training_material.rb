module ForTrainingMaterial
  extend ActiveSupport::Concern

  included do
    has_one :training_material, as: :material, dependent: :destroy
    has_one :chatbot, through: :training_material
  end

  def save_and_connect_to_chatbot(chatbot)
    # Create training material with self and connect to chatbot with transaction
    ActiveRecord::Base.transaction do
      self.save!
      training_material = chatbot.training_materials.build(material: self)
      training_material.save!
    end
    # If transaction succeeds, return true
    true
  rescue ActiveRecord::RecordInvalid => e
    # If transaction fails, return false
    errors.add(:base, e.message)
    false
  end
end