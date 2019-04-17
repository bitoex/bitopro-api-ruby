module Bitopro
  class Config
    class << self
      # @param [Config] new_instance
      attr_writer :instance

      # @return [Config]
      def instance
        @instance ||= new
      end
    end

    attr_accessor :key
    attr_accessor :secret

    def initialize(user_config = {})
      self.key = user_config[:key]
      self.secret = user_config[:secret]
    end

    def valid?
      Validator.validate(self)
    end
  end
end
