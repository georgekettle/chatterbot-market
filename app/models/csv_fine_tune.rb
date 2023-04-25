class CsvFineTune < ApplicationRecord
  include ForTrainingMaterial

  validates :name, presence: true
end
