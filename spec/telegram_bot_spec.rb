require 'spec_helper'

describe YATelegramBot do
  it 'has a version number' do
    expect(YATelegramBot::VERSION).not_to be nil
  end

  it 'can send getMe request' do
    response = TestBot.me

    expect(response['ok']).to be true
    expect(response['result']['first_name']).to eq 'test_bot'
    expect(response['result']['username']).to eq 'api_testing_bot'
  end

  it 'can get updates' do
    updates = TestBot.updates

    expect(updates.class).to be Array
    # but we can have zero updates :(
    updates.each { |m| expect(m.class).to be YATelegramBot::TelegramAPI::Message }
  end
end
