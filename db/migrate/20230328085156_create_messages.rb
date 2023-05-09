class CreateMessages < ActiveRecord::Migration[7.0]
  def change
    create_table :messages do |t|
      t.text :content
      t.references :chat, null: false, foreign_key: true
      t.belongs_to :sender, foreign_key: {to_table: :users}
      t.boolean :ai_generated, null: false, default: false

      t.timestamps
    end
  end
end
