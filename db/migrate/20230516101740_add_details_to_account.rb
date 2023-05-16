class AddDetailsToAccount < ActiveRecord::Migration[7.0]
  def change
    add_column :accounts, :url, :string
    add_column :accounts, :description, :text
  end
end
