require "rest-client"
require "openssl"
require "json"
require "base64"

require "bitopro/version"
require "bitopro/client"
require "bitopro/config"

module Bitopro
  BASE_URL = "https://api.bitopro.com/v2".freeze

  class << self
    # Configures the Bitopro API.
    #
    # @example
    #   Bitopro.configure do |config|
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

  def self.order_book(currency_pair)
    get("order-book/#{currency_pair}")
  end

  def self.ticker(currency_pair)
    get("ticker/#{currency_pair}")
  end

  def self.recent_trades(currency_pair)
    get("trades/#{currency_pair}")
  end

  protected

  def self.resource
    @resource ||= RestClient::Resource.new(BASE_URL)
  end

  def self.get(route, params = {})
    JSON.parse(resource[route].get params: params)
  end
end


