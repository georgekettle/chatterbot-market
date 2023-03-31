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

Account.all.each do |account|
  account.update!(api_key_openai: ENV['OPENAI_API_KEY'])
end

puts "Creating chatbots..."
Chatbot.create!(name: 'Bohemian wisdom', account: george_h.personal_account)
Chatbot.create!(name: 'Write lyrics like George', account: george_h.personal_account)

puts "Creating conversations..."
Chatbot.all.each do |cb|
  100.times do
    Conversation.create!(chatbot: cb, creator: john_smith)
    Conversation.create!(chatbot: cb, creator: mary_jane)
    Conversation.create!(chatbot: cb, creator: george_h)
  end
end

puts "Creating messages... (this may take a while)"
Conversation.all.each do |conv|
  20.times do
    conv.messages.create!(content: Faker::Quote.yoda, sender: conv.creator, ai_generated: false)
    conv.messages.create!(content: Faker::Quote.yoda, sender: conv.chatbot.account.owner)
  end
end
