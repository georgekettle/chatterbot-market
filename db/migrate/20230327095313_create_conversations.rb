class CreateConversations < ActiveRecord::Migration[7.0]
  def change
    create_table :conversations do |t|
      t.references :chatbot, null: false, foreign_key: true
      t.references :account, foreign_key: true
      t.boolean :test, default: false

      t.timestamps
    end
  end
end
