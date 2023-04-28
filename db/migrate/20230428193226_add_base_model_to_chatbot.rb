class AddBaseModelToChatbot < ActiveRecord::Migration[7.0]
  def change
    add_reference :chatbots, :base_model, foreign_key: true
  end
end
