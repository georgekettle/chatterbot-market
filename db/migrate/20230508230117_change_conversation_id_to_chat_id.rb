class ChangeConversationIdToChatId < ActiveRecord::Migration[7.0]
  def change
    rename_column :messages, :conversation_id, :chat_id
  end
end
