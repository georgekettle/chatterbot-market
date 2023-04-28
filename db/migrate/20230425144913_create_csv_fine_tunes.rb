class CreateCsvFineTunes < ActiveRecord::Migration[7.0]
  def change
    create_table :csv_fine_tunes do |t|
      t.string :description

      t.timestamps
    end
  end
end
