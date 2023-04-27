class Learn::CsvFineTunesController < ApplicationController
    skip_after_action :verify_authorized, only: [:about, :download_example]
    skip_before_action :update_history, only: [:download_example]

    # GET /learn/csv_fine_tunes/about
    def about
      folder_path = 'lib/assets/csv_fine_tune_examples'
      csv_files = Dir.glob("#{folder_path}/*.csv")
      @examples = csv_files.map do |file|
        name = File.basename(file, ".csv")
        { name: name&.titleize, file_name: "#{name}", file_contents: SmarterCSV.process(file) }
      end
    end

    # GET /learn/csv_fine_tunes/download_example
    def download_example
      file_name = params[:file_name]
      file_path = "lib/assets/csv_fine_tune_examples/#{file_name}.csv"
      file = Dir.glob(file_path).first
      if file
        send_file file, type: 'text/csv', disposition: 'attachment'
      else
        redirect_to about_learn_csv_fine_tunes_path, alert: "File not found: #{file_name}"
      end
    end     
end
