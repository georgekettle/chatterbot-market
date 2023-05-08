class AddSystemPromptToChatbot < ActiveRecord::Migration[7.0]
  def change
    add_column :chatbots, :system_prompt, :text
  end
end
