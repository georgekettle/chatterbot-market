class Review < ApplicationRecord
  belongs_to :reviewable, polymorphic: true
  
  validates :rating, presence: true, numericality: { only_integer: true, greater_than_or_equal_to: 1, less_than_or_equal_to: 5 }
  validates :comment, presence: true, length: { maximum: 500 }
end
