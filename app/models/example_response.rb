class ExampleResponse < ApplicationRecord
  belongs_to :message, optional: true
  has_one :training_material, as: :material, dependent: :destroy

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
end