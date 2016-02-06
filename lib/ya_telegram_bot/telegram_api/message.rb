module YATelegramBot
  module TelegramAPI
    class Message < Hash
      TYPES = [:text, :audio, :photo, :document, :video, :voice, :contact, :location].freeze

      #
      # @param hash_message [Hash] update['message']
      #
      def initialize(hash_message)
        merge! prepare_hash_to_merging(hash_message)
      end

      def [](key)
        super(key.to_s)
      end


      def method_missing(m, *args)
        return self[m] if self[m] && args.empty?
        super
      end

      #
      # checking on message type
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
      def prepare_hash_to_merging(hash)
        # TODO: conversions

        hash
      end
    end
  end
end
