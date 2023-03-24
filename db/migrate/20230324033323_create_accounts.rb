class CreateAccounts < ActiveRecord::Migration[7.0]
  def change
    create_table :accounts do |t|
      t.string :name
      t.references :owner, null: false, foreign_key: {to_table: :users}
      t.boolean :personal

      t.timestamps
    end
  end
end
