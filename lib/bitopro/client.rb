require_relative './api/account'

module Bitopro
  class Client
    class BitoproSetupError < StandardError; end

    BASE_URL = "https://api.bitopro.com/v2".freeze

    include Bitopro::Account

    def initialize
      @config = Bitopro::Config.instance
    end

    private

    def build_url(url)
      "#{BASE_URL}#{url}"
    end

    def authenticated_get(url, params = {})
      raise BitoproSetupError, "Must be set configure before call authenticate action" unless Bitopro.configured?

      complete_url = build_url(url)
      response = RestClient::Request.execute(method: :get, url: complete_url,
                            timeout: 10, headers: headers, payload: params)

      JSON.parse(response.body)
    end

    def build_payload
      body = { identity: @config.email, nonce: new_nonce }

      Base64.strict_encode64(body.to_json)
    end

    def new_nonce
      (Time.now.to_f * 1000).floor
    end

    def signature(payload)
      OpenSSL::HMAC.hexdigest("SHA384", @config.secret, payload)
    end

    def headers
      payload = build_payload

      {
        "X-BITOPRO-APIKEY": @config.key,
        "X-BITOPRO-PAYLOAD": payload,
        "X-BITOPRO-SIGNATURE": signature(payload)
      }
    end
  end
end
