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
    attr_accessor :email

    def initialize(user_config = {})
      self.key = user_config[:key]
      self.secret = user_config[:secret]
      self.email = user_config[:email]
    end

    def valid?
      Validator.validate(self)
    end
  end
end
