if Rails.env == 'development'
  Chatbot.destroy_all
  User.destroy_all
  Conversation.destroy_all
  Message.destroy_all
end

puts "Creating users..."
george_h = User.create!(email: 'george@test.com', password: 'secret', first_name: 'George', last_name: 'Harrison', time_zone: 'London')
john_smith = User.create!(email: 'john@test.com', password: 'secret', first_name: 'John', last_name: 'Smith', time_zone: 'Sydney')
mary_jane = User.create!(email: 'mary@test.com', password: 'secret', first_name: 'Mary', last_name: 'Jane', time_zone: 'New York')


puts "Creating chatbots..."
Chatbot.create!(name: 'Bohemian wisdom', account: george_h.personal_account)
Chatbot.create!(name: 'Write lyrics like George', account: george_h.personal_account)

puts "Creating conversations..."
Chatbot.all.each do |cb|
  100.times do
    Conversation.create!(chatbot: cb, account: john_smith.personal_account)
    Conversation.create!(chatbot: cb, account: mary_jane.personal_account)
    Conversation.create!(chatbot: cb, account: george_h.personal_account, test: true)
  end
end

puts "Creating messages... (this may take a while)"
Conversation.all.each do |conv|
  20.times do
    conv.messages.create!(content: Faker::Quote.yoda, account: conv.account, sender: conv.account.owner, ai_generated: false)
    conv.messages.create!(content: Faker::Quote.yoda, account: conv.chatbot.account, sender: conv.chatbot.account.owner)
  end
end
