require "telegram/bot"
require "open-uri"
require "json"
require 'dotenv'
Dotenv.load

token = ENV["TELEGRAM_TOKEN"]
@app_id = ENV["APP_ID"]
@app_key = ENV["APP_KEY"]

@labels=[]

def get_recipe(request)
  recipe = open("https://api.edamam.com/search?q=#{request}&app_id=#{@app_id}&app_key=#{@app_key}")
  @label = JSON.parse(recipe.read)
end

def get_ingredients
  @labels=[]
  @photos=[]
  @recipe=[]
  @website=[]
  @label['hits'].each_with_index do |title, index|
    @labels << "#{index+1}. #{title['recipe']['label']}"
    @photos << "#{title['recipe']['image']}"
    @recipe << "#{title['recipe']['ingredientLines']}"
    @website << "#{title['recipe']['url']}"
  end
end

get_recipe('chicken')
get_ingredients

Telegram::Bot::Client.run(token) do |bot|
  bot.listen do |message|
    case message.text
    when '/start'
      bot.api.send_message(chat_id: message.chat.id, text: "Hello, #{message.from.first_name}")
    when '/stop'
      bot.api.send_message(chat_id: message.chat.id, text: "Bye, #{message.from.first_name}")
    when '/recipes'
      get_ingredients
      bot.api.send_message(chat_id: message.chat.id, text: "#{@labels.join(", \n")}")
    when 'pork'
      get_recipe("#{message.text}")
      get_ingredients
      bot.api.send_message(chat_id: message.chat.id, text: "#{@labels.join(", \n")}")
    when 'chicken'
      get_recipe("#{message.text}")
      get_ingredients
      bot.api.send_message(chat_id: message.chat.id, text: "#{@labels.join(", \n")}")
    when '1 image'
      bot.api.send_photo(chat_id: message.chat.id, photo: "#{@photos[0]}")
    when '2 image'
      bot.api.send_photo(chat_id: message.chat.id, photo: "#{@photos[1]}")
    when '2 image'
      bot.api.send_photo(chat_id: message.chat.id, photo: "#{@photos[1]}")
    when "1 ingredients"
      bot.api.send_message(chat_id: message.chat.id, text: "#{@recipe[0]}")
    when "2 ingredients"
      bot.api.send_message(chat_id: message.chat.id, text: "#{@recipe[1]}")
    when "1 website"
      bot.api.send_message(chat_id: message.chat.id, text: "#{@website[0]}")
    when "2 website"
      bot.api.send_message(chat_id: message.chat.id, text: "#{@website[1]}")
    end
  end
end
