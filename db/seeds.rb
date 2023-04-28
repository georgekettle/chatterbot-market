if Rails.env == 'development'
  puts "Destroying all Base Models..."
  BaseModel.destroy_all
  puts "Destroying all Training Materials..."
  TrainingMaterial.destroy_all
  puts "Destroying all Chatbots..."
  Chatbot.destroy_all
  puts "Destroying all Users..."
  User.destroy_all
  puts "Destroying all Conversations..."
  Conversation.destroy_all
  puts "Destroying all Accounts..."
  Account.destroy_all
  puts "Destroying all Messages..."
  Message.destroy_all
  puts "Destroying all Feedback..."
  Feedback.destroy_all
  puts "Destroying all Example Responses..."
  Correction.destroy_all
end

puts "Creating users..."
george_h = User.create!(email: 'george@test.com', password: 'secret', first_name: 'George', last_name: 'Harrison', time_zone: 'London')
john_smith = User.create!(email: 'john@test.com', password: 'secret', first_name: 'John', last_name: 'Smith', time_zone: 'Sydney')
mary_jane = User.create!(email: 'mary@test.com', password: 'secret', first_name: 'Mary', last_name: 'Jane', time_zone: 'New York')

Account.all.each do |account|
  account.update!(api_key_openai: ENV['OPENAI_API_KEY'])
end

puts "Creating base models..."
CHATTERBOT_OPENAI_CLIENT.models.list["data"].select{|obj| obj["owned_by"] == 'openai'}.each do |model|
  BaseModel.create!(name: model["id"], company: model["owned_by"])
end

puts "Creating chatbots..."
Chatbot.create!(name: 'Bohemian wisdom', base_model: BaseModel.first, description: 'A chatbot for users to find the bohemian wisdom of George Harrison', account: george_h.personal_account, status: :published)
Chatbot.create!(name: 'Write lyrics like George', base_model: BaseModel.second, description: 'Generate song lyrics like George Harrison', account: george_h.personal_account)

puts "Creating conversations..."
Chatbot.all.each do |cb|
  25.times do
    Conversation.create!(chatbot: cb, creator: john_smith)
    Conversation.create!(chatbot: cb, creator: mary_jane)
    Conversation.create!(chatbot: cb, creator: george_h)
  end
end

puts "Creating messages... (this may take a while)"
Conversation.all.each do |conv|
  20.times do
    conv.messages.create!(content: Faker::GreekPhilosophers.quote, sender: conv.creator, ai_generated: false)
    conv.messages.create!(content: Faker::GreekPhilosophers.quote, sender: conv.chatbot.account.owner)
  end
end

puts "Creating Feedback for messages... (created by chatbot or chatbot account users)"
Message.all.each do |message|
  if message.sender != message.conversation.creator
    if rand(1..10) > 2
      Feedback.create!(content: Faker::GreekPhilosophers.quote, user: message.conversation.creator, message: message, rating: :negative)
    else
      Feedback.create!(content: Faker::GreekPhilosophers.quote, user: message.conversation.creator, message: message, rating: :positive)
    end
  end
end

puts "Creating Corrections..."
Message.all.each do |message|
  if message.sender != message.conversation.creator
    if rand(1..10) > 2
      # Transaction to ensure that if one fails, they all fail
      ActiveRecord::Base.transaction do
        eg_res = Correction.create!(message: message, prompt: message.previous_message.content, response: Faker::GreekPhilosophers.quote)
        TrainingMaterial.create!(chatbot: message.chatbot, material: eg_res)
      end      
    end
  end
end

puts "Done!"
