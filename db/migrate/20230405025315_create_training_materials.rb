class CreateTrainingMaterials < ActiveRecord::Migration[7.0]
  def change
    create_table :training_materials do |t|
      t.references :material, polymorphic: true, null: false
      t.references :chatbot, null: false, foreign_key: true

      t.timestamps
    end
  end
end
