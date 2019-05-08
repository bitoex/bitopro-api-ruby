require_relative './api/account'
require_relative './api/public'
require_relative './api/order'

module Bitopro
  class Client
    class SetupError < StandardError; end

    BASE_URL = "https://api.bitopro.com/v2".freeze

    include Bitopro::Public
    include Bitopro::Account
    include Bitopro::Order

    def initialize
      @config = Bitopro::Config.instance
    end

    private

    def build_url(url)
      "#{BASE_URL}#{url}"
    end

    def authenticated_get(url, params = {})
      raise SetupError, "Must be set configure before call authenticate action" unless Bitopro.configured?

      complete_url = build_url(url)

      json_body = { identity: @config.email, nonce: timestamp }.to_json
      payload = build_payload(json_body)
      headers = build_headers(payload)

      response = RestClient::Request.execute(method: :get,
                                             url: complete_url,
                                             headers: headers,
                                             payload: params,
                                             timeout: 10)

      JSON.parse(response.body)
    end

    def authenticated_post(url, params = {})
      raise SetupError, "Must be set configure before call authenticate action" unless Bitopro.configured?

      complete_url = build_url(url)

      json_body = params[:body].to_json
      payload = build_payload(json_body)
      headers = build_headers(payload)

      response = RestClient::Request.execute(method: :post,
                                             url: complete_url,
                                             headers: headers,
                                             payload: json_body,
                                             timeout: 10)

      JSON.parse(response.body)
    end

    def authenticated_delete(url, params = {})
      raise BitoproSetupError, "Must be set configure before call authenticate action" unless Bitopro.configured?

      complete_url = build_url(url)

      json_body = { identity: @config.email, nonce: timestamp }.to_json
      payload = build_payload(json_body)
      headers = build_headers(payload)

      response = RestClient::Request.execute(method: :delete,
                                             url: complete_url,
                                             headers: headers,
                                             payload: params,
                                             timeout: 10)

      JSON.parse(response.body)
    end

    def get(url, params = {})
      complete_url = build_url(url)
      headers = { "X-BITOPRO-API": "ruby" }
      response = RestClient::Request.execute(method: :get,
                                             url: complete_url,
                                             payload: params,
                                             headers: headers,
                                             timeout: 10)

      JSON.parse(response.body)
    end

    def build_payload(json_body)
      Base64.strict_encode64(json_body)
    end

    def timestamp
      (Time.now.to_f * 1000).floor
    end

    def signature(payload)
      OpenSSL::HMAC.hexdigest("SHA384", @config.secret, payload)
    end

    def build_headers(payload)
      {
        "X-BITOPRO-API": "ruby",
        "X-BITOPRO-APIKEY": @config.key,
        "X-BITOPRO-PAYLOAD": payload,
        "X-BITOPRO-SIGNATURE": signature(payload)
      }
    end
  end
end
