module Bitopro
  module Account
    class Error < StandardError; end

    def account_balance
      authenticated_get("/accounts/balance")
    end

    def order_history
      authenticated_get("/orders/history")
    end

    def order_list(pair: "", page: 1, active: false)
      raise Error, "pair is required" unless pair

      authenticated_get("/orders/#{pair}", params: { page: page, active: active })
    end
  end
end
