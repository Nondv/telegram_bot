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
    end
  end
end
