if Rails.env == 'development'
  puts "Destroying all Base Models..."
  BaseModel.destroy_all
  puts "Destroying all Chatbots..."
  Chatbot.destroy_all
  puts "Destroying all Users..."
  User.destroy_all
  puts "Destroying all Chats..."
  Chat.destroy_all
  puts "Destroying all Accounts..."
  Account.destroy_all
  puts "Destroying all Messages..."
  Message.destroy_all
  puts "Destroying all Feedback..."
  Feedback.destroy_all
end

puts "Creating users..."
george_h = User.create!(email: 'george@test.com', password: 'secret', first_name: 'George', last_name: 'Harrison', time_zone: 'London')
john_smith = User.create!(email: 'john@test.com', password: 'secret', first_name: 'John', last_name: 'Smith', time_zone: 'Sydney')
mary_jane = User.create!(email: 'mary@test.com', password: 'secret', first_name: 'Mary', last_name: 'Jane', time_zone: 'New York')

Account.all.each do |account|
  account.update!(api_key_openai: ENV['OPENAI_API_KEY'])
end

puts "Creating base models..."
openai_gpt_models = CHATTERBOT_OPENAI_CLIENT.models.list["data"].select{|obj| obj["owned_by"] == 'openai' && obj["id"].match?(/gpt/) }
openai_gpt_models.each do |model|
  BaseModel.create!(name: model["id"], company: model["owned_by"])
end

puts "Creating chatbots..."
Chatbot.create!(name: 'JSON API',
  base_model: BaseModel.first,
  description: 'A chatbot that only speaks JSON.',
  account: george_h.personal_account,
  status: :published,
  system_prompt: "You are an assistant that only speaks JSON. Do not write normal text.")
Chatbot.create!(name: 'Ruby on Rails Code Assistant',
  base_model: BaseModel.second,
  description: 'Be guided through creating a Ruby on Rails application with this chatbot.',
  account: george_h.personal_account,
  system_prompt: "Welcome to the Ruby on Rails Code Assistant! How can I help you today with your coding needs? Whether you're looking for guidance on specific methods, syntax, or best practices, feel free to ask any questions or share your code snippet to receive personalized support and recommendations for optimizing your Ruby on Rails project.")

puts "Creating chats..."
Chatbot.all.each do |cb|
  25.times do
    Chat.create!(chatbot: cb, creator: john_smith)
    Chat.create!(chatbot: cb, creator: mary_jane)
    Chat.create!(chatbot: cb, creator: george_h)
  end
end

puts "Creating messages... (this may take a while)"
Chat.all.each do |conv|
  20.times do
    conv.messages.create!(content: Faker::GreekPhilosophers.quote, sender: conv.creator, ai_generated: false)
    conv.messages.create!(content: Faker::GreekPhilosophers.quote, sender: conv.chatbot.account.owner)
  end
end

puts "Creating Feedback for messages... (created by chatbot or chatbot account users)"
Message.all.each do |message|
  if message.sender != message.chat.creator
    if rand(1..10) > 2
      Feedback.create!(content: Faker::GreekPhilosophers.quote, user: message.chat.creator, message: message, rating: :negative)
    else
      Feedback.create!(content: Faker::GreekPhilosophers.quote, user: message.chat.creator, message: message, rating: :positive)
    end
  end
end

puts "Done!"
