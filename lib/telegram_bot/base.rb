require 'rest-client'
require 'json'

module TelegramBot
  #
  # extend your class with this module to use API.
  # Or include it if you want to use in instances
  #
  module Base
    def token(value)
      @token = value
      @api_request_prefix = "bot#{@token}"
      @last_update_id = -1 # hmmm
    end

    def get_me
      send_api_request 'getMe'
    end

    private

    def send_api_request(method, params = {})
      fail NoTokenSpecified unless defined?(@token)
      @telegram_api_url = 'https://api.telegram.org' unless defined? @telegram_api_url
      JSON.parse RestClient.get "#{@telegram_api_url}/#{@api_request_prefix}/#{method}",
                                params: params
    end
  end
end
