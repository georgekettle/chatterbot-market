class ChangeConversationsToChats < ActiveRecord::Migration[7.0]
  def change
    rename_table :conversations, :chats
  end
end
