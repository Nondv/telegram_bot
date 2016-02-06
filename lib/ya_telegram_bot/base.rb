require 'rest-client'
require 'json'
require 'time'

require_relative 'exceptions'
Dir[File.expand_path('../telegram_api/*.rb', __FILE__)].each { |file| require file }

module YATelegramBot
  #
  # extend your class with this module to use API.
  # Or include it if you want to use in instances
  #
  module Base
    include TelegramAPI

    def token(value)
      @token = value
      @api_request_prefix = "bot#{@token}"
      @last_update_id = -1 # hmmm
    end

    def me
      send_api_request 'getMe'
    end

    #
    # loads last updates.
    # Note than after each #updates your @last_update_id will be changed so
    # if you use it twice you won't get same result
    #
    def updates
      updates = send_api_request 'getUpdates', offset: @last_update_id + 1
      fail ResponseIsNotOk unless updates['ok']

      @last_update_id = updates['result'].last['update_id'] unless updates['result'].empty?
      updates['result'].map { |u| Message.new(u['message'], self) }
    end

    #
    # send text message to user.
    #
    # required params:
    # * :chat - id of chat
    # * :text - your message
    #
    # additional params:
    # * :markdown [Boolean] use telegram markdown
    # * :reply_to [Integer] id of message you reply
    #
    def send_text(params = {})
      response = send_api_request 'sendMessage',
                                  params_for_sending_text(params)
      response['ok']
    end

    private

    def params_for_sending_text(params)
      fail NoChatSpecified unless params[:chat]
      fail NoMessageSpecified unless params[:text]

      result = {}
      result[:chat_id] = params[:chat]
      result[:text] = params[:text]
      result[:parse_mode] = 'Markdown' if params[:markdown]
      result[:reply_to_message_id] = params[:reply_to].to_i if params[:reply_to]

      result
    end

    def send_api_request(method, params = {})
      fail NoTokenSpecified unless defined?(@token)
      @telegram_api_url = 'https://api.telegram.org' unless defined? @telegram_api_url
      JSON.parse RestClient.post "#{@telegram_api_url}/#{@api_request_prefix}/#{method}",
                                 params
      # rescue RestClient::ExceptionWithResponse => err
      # err.response.request
    end
  end
end
