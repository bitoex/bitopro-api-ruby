require_relative './api/account'
require_relative './api/public'
require_relative './api/order'

module Bitopro
  class Client
    class SetupError < StandardError; end

    AUTH_HTTP_ACTION = %w(get post delete)
    BASE_URL = "https://api.bitopro.com/v2".freeze

    include Bitopro::Public
    include Bitopro::Account
    include Bitopro::Order

    def initialize
      @config = Bitopro::Config.instance
    end

    private

    def complete_url(url)
      "#{BASE_URL}#{url}"
    end

     AUTH_HTTP_ACTION.each do |action|
      define_method "authenticated_#{action}" do |url, params = {}|
        raise SetupError, "Must be set configure before call authenticate action" unless Bitopro.configured?

        json_body = build_json_body(params: params, action: action)
        payload = build_payload(json_body)
        headers = build_headers(payload)

        response = RestClient::Request.execute(method: action,
                                               url: complete_url(url),
                                               headers: headers,
                                               payload: params,
                                               timeout: 10)

        JSON.parse(response.body)
      end
    end

    def get(url, params = {})
      response = RestClient::Request.execute(method: :get,
                                             url: complete_url(url),
                                             payload: params,
                                             headers: tracking_header,
                                             timeout: 10)

      JSON.parse(response.body)
    end

    def build_payload(json_body)
      Base64.strict_encode64(json_body)
    end

    def build_json_body(params:, action:)
      body = action == "post" ? params[:body] : { identity: @config.email, nonce: timestamp }
      body.to_json
    end

    def timestamp
      (Time.now.to_f * 1000).floor
    end

    def signature(payload)
      OpenSSL::HMAC.hexdigest("SHA384", @config.secret, payload)
    end

    def tracking_header
      { "X-BITOPRO-API": "ruby" }
    end

    def build_headers(payload)
      {
        "X-BITOPRO-APIKEY": @config.key,
        "X-BITOPRO-PAYLOAD": payload,
        "X-BITOPRO-SIGNATURE": signature(payload)
      }.merge!(tracking_header)
    end
  end
end
