class AddDescriptionToChatbots < ActiveRecord::Migration[7.0]
  def change
    add_column :chatbots, :description, :text
  end
end
