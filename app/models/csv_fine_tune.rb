require 'csv'
require 'open-uri'

class CsvFineTune < ApplicationRecord
  include ForTrainingMaterial

  has_one_attached :csv_file

  validates :csv_file, presence: true
  validate :validate_csv_file_structure

  private

  def validate_csv_file_structure
    return if csv_file.blank?

    csv_file_path = self.attachment_changes['csv_file'].attachable.path

    begin
      csv_data = CSV.read(csv_file_path, headers: true)
      header_columns = csv_data.headers

      # Add validation for header columns
      unless header_columns == ['prompt', 'response']
        errors.add(:csv_file, "must have two columns: 'prompt' and 'response' (case-sensitive)")
      end

      # Add validation for empty rows and empty columns
      if csv_data.any? { |row| row.to_hash.values.any?(&:blank?) }
        errors.add(:csv_file, 'must not have empty rows or empty columns')
      end

    rescue CSV::MalformedCSVError
      errors.add(:csv_file, 'is not a valid CSV file')
    end
  end
end
