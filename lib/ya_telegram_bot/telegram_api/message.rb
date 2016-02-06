require 'time'

module YATelegramBot
  module TelegramAPI
    class Message < Hash
      TYPES = [:text, :audio, :photo, :document, :video, :voice, :contact, :location].freeze

      #
      # @param hash_message [Hash] update['message']
      #
      def initialize(hash_message)
        merge! hash_to_merging(hash_message)
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

      # @return [Symbol] type of a message (see Message::TYPES)
      def type
        TYPES.find { |t| self[t] }
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

        TYPES.each do |t|
          next unless hash[t.to_s]

          new_hash[t] = hash[t.to_s]
          break
        end

        new_hash
      end
    end
  end
end
