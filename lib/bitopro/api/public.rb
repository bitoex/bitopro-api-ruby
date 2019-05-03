module Bitopro
  module Public
    class Error < StandardError; end

    def order_book(currency_pair)
      raise Error, "currency_pair is required" unless currency_pair

      get("/order-book/#{currency_pair}")
    end

    def ticker(currency_pair)
      raise Error, "currency_pair is required" unless currency_pair

      get("/ticker/#{currency_pair}")
    end

    def recent_trades(currency_pair)
      raise Error, "currency_pair is required" unless currency_pair

      get("/trades/#{currency_pair}")
    end
  end
end
