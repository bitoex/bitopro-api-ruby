module Bitopro
  class Config
    class Validator
      class << self
        Error = Class.new(StandardError)

        def validate(config)
          errors = []

          unless valid_key?(config)
            errors << 'key is required'
          end
          unless valid_secret?(config)
            errors << 'secret is required'
          end

          errors.empty?
        end

        private

        def valid_key?(config)
          return true if config.key.to_i > 0
          false
        end

        def valid_secret?(config)
          return false unless config.secret.is_a?(String)
          return false if config.secret.empty?
          true
        end
      end
    end
  end
end
