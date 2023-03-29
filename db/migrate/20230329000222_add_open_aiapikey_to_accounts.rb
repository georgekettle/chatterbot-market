class AddOpenAiapikeyToAccounts < ActiveRecord::Migration[7.0]
  def change
    add_column :accounts, :api_key_openai, :string
  end
end
