class ExampleResponse < ApplicationRecord
  belongs_to :message, optional: true
  has_one :training_material, as: :material, dependent: :destroy
  has_one :chatbot, through: :training_material

  validates :prompt, presence: true
  validates :response, presence: true

  before_save :set_fine_tune_object

  def set_fine_tune_object
    self.fine_tune_object = {
      prompt: prompt,
      completion: response
    }
  end

  def fine_tune_json
    fine_tune_object.to_json
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
