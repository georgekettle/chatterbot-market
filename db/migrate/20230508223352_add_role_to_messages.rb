class AddRoleToMessages < ActiveRecord::Migration[7.0]
  def change
    add_column :messages, :role, :integer, default: 0, null: false
  end
end
