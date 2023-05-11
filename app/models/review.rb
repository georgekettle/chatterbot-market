class Review < ApplicationRecord
  belongs_to :user
  belongs_to :reviewable, polymorphic: true
  
  validates :rating, presence: true, numericality: { only_integer: true, greater_than_or_equal_to: 1, less_than_or_equal_to: 5 }
  validates :comment, presence: true, length: { maximum: 500 }
  validate :no_update_after_5_days, on: :update

  def no_update_after_5_days
    if created_at && created_at < 1.days.ago
      errors.add(:base, "Cannot edit review after 5 days of creation.")
    end
  end
end
