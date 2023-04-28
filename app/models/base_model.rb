class BaseModel < ApplicationRecord
  validates :name, presence: true
  validates :company, presence: true
end
