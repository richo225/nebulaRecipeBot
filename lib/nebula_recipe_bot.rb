require "telegram/bot"
require "open-uri"
require "json"
require 'dotenv'
Dotenv.load

token = ENV["TELEGRAM_TOKEN"]
app_id = ENV["APP_ID"]
app_key = ENV["APP_KEY"]
url = "https://api.edamam.com/search?q=chicken&app_id=#{app_id}&app_key=#{app_key}"

recipe = open(url)

labels = []
label = JSON.parse(recipe.read)

label['hits'].each do |title|
  labels << title['recipe']['label']
end

p labels

Telegram::Bot::Client.run(token) do |bot|
  bot.listen do |message|
    case message.text
    when '/start'
      bot.api.send_message(chat_id: message.chat.id, text: "Hello, #{message.from.first_name}")
    when '/stop'
      bot.api.send_message(chat_id: message.chat.id, text: "Bye, #{message.from.first_name}")
    end
  end
end
