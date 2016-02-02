require 'spec_helper'

describe TelegramBot do
  class TestBot
    extend TelegramBot::Base

    token '188286713:AAE3kjZc74i3hw8nTCv4lLjY0nWxZOBWTwo'
  end

  it 'has a version number' do
    expect(TelegramBot::VERSION).not_to be nil
  end

  it 'can send getMe request' do
    response = TestBot.me

    expect(response['ok']).to be true
    expect(response['result']['first_name']).to eq 'test_bot'
    expect(response['result']['username']).to eq 'api_testing_bot'
  end
end
