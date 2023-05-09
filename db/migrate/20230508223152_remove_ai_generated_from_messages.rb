class RemoveAiGeneratedFromMessages < ActiveRecord::Migration[7.0]
  def change
    remove_column :messages, :ai_generated, :boolean
  end
end
