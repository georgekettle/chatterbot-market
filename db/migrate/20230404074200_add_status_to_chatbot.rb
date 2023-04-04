class AddStatusToChatbot < ActiveRecord::Migration[7.0]
  def change
    add_column :chatbots, :status, :integer, null: false, default: 0
  end
end
