class CsvFineTune < ApplicationRecord
  include ForTrainingMaterial

  has_one_attached :csv_file

  validates :name, presence: true
end
