class Createchats < ActiveRecord::Migration[7.0]
  def change
    create_table :conversations do |t|
      t.references :chatbot, null: false, foreign_key: true
      t.belongs_to :creator, foreign_key: {to_table: :users}

      t.timestamps
    end
  end
end
