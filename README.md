# Yet Another Telegram Bot

**IN DEV**

## Usage

```ruby
require 'ya_telegram_bot'

class Bot
  extend YATelegramBot::Base

  token YOUR_TOKEN
end

updates = Bot.updates
updates.each do |message|
  chat_id = message['chat']['id']
  user = message['from']['first_name']
  text = "Hello, *#{user}*"

  Bot.send_text chat: chat_id,
                text: text,
                markdown: true
end
```

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/Nondv/telegram_bot. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.


## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).

