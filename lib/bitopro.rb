require "bitopro/version"
require "bitopro/config"
require "bitopro/config/validator"

module Bitopro
  class << self
    # Configures the Bitopro API.
    #
    # @example
    #   Bitopro.configure do |c|
    #     config.key = 113743
    #     config.secret = 'fd04e13d806a90f96614ad8e529b2822'
    #   end
    def configure
      yield config = Bitopro::Config.instance
    end

    def configured?
      Bitopro::Config.instance.valid?
    end
  end
end
