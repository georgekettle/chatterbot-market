class CreateCorrections < ActiveRecord::Migration[7.0]
  def change
    create_table :corrections do |t|
      t.text :prompt
      t.text :response
      t.belongs_to :message, foreign_key: true
      t.jsonb :fine_tune_object, null: false, default: {}

      t.timestamps
    end
  end
end
