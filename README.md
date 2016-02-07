# Yet Another Telegram Bot

**IN DEV**

## What's new **0.4.0**

* `#send_photo` method on `Base`, `User`, `Chat`

## Usage

```ruby
require 'ya_telegram_bot'

class Bot
  extend YATelegramBot::Base

  token YOUR_TOKEN
end

# getting LAST updates as array of YATelegramBot:TelegramAPI::Message
# "LAST" means that #updates method every time will return fresh updates (so you will never get same updates inside your process)
updates = Bot.updates
updates.each do |message|
  chat_id = message['chat']['id']
  user = message['from']['first_name']
  text = "Hello, *#{user}*"

  Bot.send_text chat: chat_id,
                text: text,
                markdown: true
end

# reply to message
Bot.updates.each { |message| message.reply text: 'Leave me alone!' }

# YATelegramBot::TelegramAPI::User
user = Bot.updates[0].from
user.send_text text: '*hey hey!*',
               markdown: true

#YATelegramBot::TelegramAPI::Chat
chat = Bot.updates[0].chat
chat.send_text text: "Hi, #{chat.type == :private ? 'dude' : 'all'}!"

# send photo
user.send_photo file: File.new('my_awesome_photo.png'), caption: 'awesome photo'

```

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/Nondv/telegram_bot.
This project is intended to be a safe, welcoming space for collaboration,
and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.


## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).

