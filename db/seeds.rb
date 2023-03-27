if Rails.env == 'development'
  Chatbot.destroy_all
  User.destroy_all
end

george_h = User.create!(email: 'george@test.com', password: 'secret', first_name: 'George', last_name: 'Harrison', time_zone: 'London')
john_smith = User.create!(email: 'john@test.com', password: 'secret', first_name: 'John', last_name: 'Smith', time_zone: 'Sydney')
mary_jane = User.create!(email: 'mary@test.com', password: 'secret', first_name: 'Mary', last_name: 'Jane', time_zone: 'New York')

# Create a chatbot
Chatbot.create!(name: 'Bohemian wisdom', account: george_h.personal_account)
Chatbot.create!(name: 'Write lyrics like George', account: george_h.personal_account)

# Create conversations
Chatbot.all.each do |cb|
  4.times do
    Conversation.create!(chatbot: cb, account: john_smith.personal_account)
    Conversation.create!(chatbot: cb, account: mary_jane.personal_account)
    Conversation.create!(chatbot: cb, account: george_h.personal_account, test: true)
  end
end
