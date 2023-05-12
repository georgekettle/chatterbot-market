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

# Create Chatbot seeds
puts "Creating chatbots..."
messages = [
  { role: "system", content: "You are an assistant that only speaks JSON. Do not write normal text." },
  { role: "user", content: "Write an array of 10 custom chatbots for specific tasks with the following fields: name, description, system_prompt. The system prompt should describe the personality of the bot and it's goals" }
]
response = CHATTERBOT_OPENAI_CLIENT.chat(
  parameters: {
    model: "gpt-3.5-turbo",
    messages: messages,
    temperature: 0.5
  }
)
puts "Response: "
puts response

chatbots_examples = JSON.parse(response.dig("choices", 0, "message", "content"), {:symbolize_names => true})

chatbots_examples.each do |cb|
  created_chatbot = Chatbot.create!(name: cb[:name],
    base_model: BaseModel.first,
    description: cb[:description],
    account: Account.all.sample,
    status: :marketplace,
    system_prompt: cb[:system_prompt])
  # Attach image
  img = URI.open("https://source.unsplash.com/random/?texture,background")
  created_chatbot.avatar.attach(io: img, filename: "#{cb[:name]}.jpg", content_type: 'image/jpg')
end

puts "Creating chatbots..."
json_chatbot = Chatbot.create!(name: 'JSON API',
  base_model: BaseModel.first,
  description: 'A chatbot that only speaks JSON.',
  account: george_h.personal_account,
  status: :published,
  system_prompt: "You are an assistant that only speaks JSON. Do not write normal text.")
img = URI.open("https://source.unsplash.com/random/?texture,background")
json_chatbot.avatar.attach(io: img, filename: "#{json_chatbot.name}.jpg", content_type: 'image/jpg')

ruby_chatbot = Chatbot.create!(name: 'Ruby on Rails Code Assistant',
  base_model: BaseModel.second,
  description: 'Be guided through creating a Ruby on Rails application with this chatbot.',
  account: george_h.personal_account,
  system_prompt: "Welcome to the Ruby on Rails Code Assistant! How can I help you today with your coding needs? Whether you're looking for guidance on specific methods, syntax, or best practices, feel free to ask any questions or share your code snippet to receive personalized support and recommendations for optimizing your Ruby on Rails project.")
img = URI.open("https://source.unsplash.com/random/?texture,background")
ruby_chatbot.avatar.attach(io: img, filename: "#{ruby_chatbot.name}.jpg", content_type: 'image/jpg')

puts "Creating chats..."
Chatbot.all.each do |cb|
  # Create 10 chats for each chatbot
  10.times do
    Chat.create!(chatbot: cb, creator: john_smith)
    Chat.create!(chatbot: cb, creator: mary_jane)
    Chat.create!(chatbot: cb, creator: george_h)
  end
  # Create 10 reviews for each chatbot
  User.all.each do |user|
    cb.reviews.create!(user: user, rating: rand(1..5), comment: Faker::Lorem.paragraph(sentence_count: rand(1..5)))
  end
end

puts "Creating messages... (this may take a while)"
Chat.all.each do |chat|
  10.times do
    chat.messages.create!(content: Faker::GreekPhilosophers.quote, role: :user)
    chat.messages.create!(content: Faker::GreekPhilosophers.quote, role: :assistant)
  end
end

puts "Done!"
