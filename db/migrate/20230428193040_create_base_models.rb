class CreateBaseModels < ActiveRecord::Migration[7.0]
  def change
    create_table :base_models do |t|
      t.string :name
      t.string :company

      t.timestamps
    end
  end
end
