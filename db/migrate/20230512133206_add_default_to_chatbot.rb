class AddDefaultToChatbot < ActiveRecord::Migration[7.0]
  def change
    add_column :chatbots, :default, :boolean, default: false
  end
end
