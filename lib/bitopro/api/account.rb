module Bitopro
  module Account
    def account_balance
      authenticated_get("/accounts/balance")
    end

    def order_history
      authenticated_get("/orders/history")
    end

    def order_list(currency_pair, page = 1, active = false)
      authenticated_get("/orders/#{currency_pair}", params: { page: page, active: active })
    end
  end
end
