require "telegram/bot"
require "open-uri"
require "json"
require 'dotenv'
Dotenv.load

token = ENV["TELEGRAM_TOKEN"]
@app_id = ENV["APP_ID"]
@app_key = ENV["APP_KEY"]
# url = "https://api.edamam.com/search?q=chicken&app_id=#{app_id}&app_key=#{app_key}"

# recipe = open(url)
# @label = JSON.parse(recipe.read)
# @labels=[]

def get_recipe(request)
  recipe = open("https://api.edamam.com/search?q=#{request}&app_id=#{@app_id}&app_key=#{@app_key}")
  @label = JSON.parse(recipe.read)
end

def get_ingredients
  @labels=[]
  @photos=[]
  @recipe=[]
  @label['hits'].each_with_index do |title, index|
    @labels << "#{index+1}. #{title['recipe']['label']}"
    @photos << "#{title['recipe']['image']}"
    @recipe << "#{title['recipe']['ingredientLines']}"
  end
end

# get_recipe('chicken')

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
    end
  when '2 image'
    bot.api.send_photo(chat_id: message.chat.id, photo: "#{@photos[1]}")
  end
  end
end
