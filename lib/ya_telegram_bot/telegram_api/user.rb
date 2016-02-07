module YATelegramBot
  module TelegramAPI
    #
    # represents Telegram User
    #
    class User < Hash
      FIELDS = [:id, :first_name, :last_name, :username].freeze

      #
      # @param hash [Hash] hash from json.
      # @param bot [Base] for using api methods
      #
      def initialize(hash, bot = nil)
        super()
        @bot = bot
        FIELDS.each { |f| self[f] = hash[f.to_s] if hash[f.to_s] }
      end

      #
      # @example user.first_name
      #
      def method_missing(m, *args)
        return self[m] if self[m] && args.empty?
        super
      end

      #
      # uses bot to send text to this user.
      #
      # @param params [Hash] params for Base#send_text. This method will only set :chat to self[:id]
      #
      def send_text(params = {})
        fail InitWithoutBot unless @bot

        params[:chat] = id
        @bot.send_text params
      end

      #
      # uses bot to send photo to this user.
      #
      # @param params [Hash] params for Base#send_photo. This method will only set :chat to self[:id]
      #
      def send_photo(params = {})
        fail InitWithoutBot unless @bot

        params[:chat] = id
        @bot.send_photo params
      end
    end
  end
end
