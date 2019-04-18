module Bitopro
  module Public
    def order_book(currency_pair)
      get("/order-book/#{currency_pair}")
    end

    def ticker(currency_pair)
      get("/ticker/#{currency_pair}")
    end

    def recent_trades(currency_pair)
      get("/trades/#{currency_pair}")
    end
  end
end
