if Rails.env == 'development'
  Chatbot.destroy_all
  User.destroy_all
end

george = User.create!(email: 'test@test.com', password: 'secret', first_name: 'George', last_name: 'Kettle', time_zone: 'Sydney')

# Create a chatbot
Chatbot.create!(name: 'My First Chatbot', account: george.personal_account)
Chatbot.create!(name: 'My Second Chatbot', account: george.personal_account)