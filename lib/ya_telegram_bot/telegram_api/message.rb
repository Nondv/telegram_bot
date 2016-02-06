require 'time'

module YATelegramBot
  module TelegramAPI
    #
    # represents incoming messages
    #
    class Message < Hash
      TYPES = [:text, :audio, :photo, :document, :video, :voice, :contact, :location].freeze

      #
      # @param hash_message [Hash] update['message']
      # @param bot [Base] for using api like sending replies
      #
      def initialize(hash_message, bot = nil)
        @bot = bot
        merge! hash_for_merging(hash_message)
      end

      #
      # @example message.text
      #
      def method_missing(m, *args)
        return self[m] if self[m] && args.empty?
        super
      end

      #
      # checking on message type via `message.<type>?`
      # @example message.text?
      #
      TYPES.each do |t|
        define_method("#{t}?") { self[t] }
      end

      #
      # @return [Symbol] type of a message (see Message::TYPES)
      #
      def type
        TYPES.find { |t| self[t] }
      end

      #
      # send reply to this message via bot from #initialize
      #
      # params values:
      # * :text [String]
      # * :as_plain_message [Boolean] default: true. If it's set, method won't set :reply_to parameter
      #
      # @example message.reply(text: 'Hi, *friend*!', markdown: true)
      #
      def reply(params = {})
        fail InitWithoutBot unless @bot

        params[:chat] = self[:chat]['id']

        params[:as_plain_message] = true unless params.key? :as_plain_message
        params[:reply_to] = self[:id] unless params[:as_plain_message]
        param.delete :as_plain_message

        @bot.send_text params
      end

      private

      #
      # converts some fields like 'user'
      # @return [Hash]
      #
      def hash_for_merging(hash)
        new_hash = {}
        new_hash[:id] = hash['message_id'].to_i
        new_hash[:date] = Time.at hash['date'].to_i
        new_hash[:from] = hash['from'] # TODO: class User
        new_hash[:chat] = hash['chat'] # TODO: class Chat

        type = TYPES.find { |t| hash[t.to_s] }
        new_hash[type] = hash[type.to_s] # TODO: fail if type not found

        new_hash
      end
    end
  end
end
