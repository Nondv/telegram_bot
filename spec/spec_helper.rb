$LOAD_PATH.unshift File.expand_path('../../lib', __FILE__)
require 'ya_telegram_bot'

TEST_TOKEN = '188286713:AAE3kjZc74i3hw8nTCv4lLjY0nWxZOBWTwo'

class TestBot
  extend YATelegramBot::Base

  token TEST_TOKEN
end
