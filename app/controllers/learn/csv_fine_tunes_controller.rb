class Learn::CsvFineTunesController < ApplicationController
    skip_after_action :verify_authorized, only: [:examples]

    # GET /learn/csv_fine_tunes/examples
    def examples
      folder_path = 'lib/assets/csv_fine_tune_examples'
      csv_files = Dir.glob("#{folder_path}/*.csv")
      @examples = csv_files.map do |file|
        name = File.basename(file, ".csv")
        { name: name&.titleize, file_name: "#{name}.jpg", file_contents: SmarterCSV.process(file) }
      end
    end
end
