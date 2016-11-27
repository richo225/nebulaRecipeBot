Nebula Recipe Bot
=================

A telegram chatbot built with ruby using the [telegram-bot-ruby](https://github.com/atipugin/telegram-bot-ruby) gem. Users can type in an ingredient and the bot will return a list of recipes that include the ingredient. From there they can select a recipe and via different commands see a list of its ingredients, cooking instructions, images and website urls.

Installation
------------
Clone the repository
```
$git clone https://github.com/richo225/nebulaRecipeBot.git
$cd nebulaRecipeBot
```
Insert your own bot and API keys
```
token = ENV["TELEGRAM_TOKEN"]
@app_id = ENV["APP_ID"]
@app_key = ENV["APP_KEY"]
```
Run the code
```
$ruby ./lib/nebula_recipe_bot.rb
```
Running the bot (Telegram)
---------------
```
/start
```
Greets you
```
*ingredient*
```
Returns a list of recipes
```
*selection_number* ingredients
```
Returns an array of ingredients

```
*selection_number* image
```
Displays an image of the food
```
*selection_number* website
```
Displays the url for cooking instructions

Examples
--------
![nebula_bot_1](https://cloud.githubusercontent.com/assets/18379191/20644766/c7a2c766-b439-11e6-9553-f26f7023b2bf.png)

![nebula_bot_2](https://cloud.githubusercontent.com/assets/18379191/20644768/c7aee0be-b439-11e6-82c8-8488cc487f4b.png)

![nebula_bot_3](https://cloud.githubusercontent.com/assets/18379191/20644767/c7ad981c-b439-11e6-9e73-b23c995ede47.png)

![nebula_bot_4](https://cloud.githubusercontent.com/assets/18379191/20644769/c7b0df2c-b439-11e6-8158-c6c96cf347e4.png)
