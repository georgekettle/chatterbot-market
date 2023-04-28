class AddAutopilotToChatbot < ActiveRecord::Migration[7.0]
  def change
    add_column :chatbots, :autopilot, :boolean, default: false
  end
end
