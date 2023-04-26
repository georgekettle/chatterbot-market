class CsvFineTune < ApplicationRecord
  include ForTrainingMaterial

  has_one_attached :csv_file

  validates :csv_file, presence: true
end
