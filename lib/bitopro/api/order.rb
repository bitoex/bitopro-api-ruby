module Bitopro
  module Order
    # Example:
    # client = Bitopro::Client.new
    # client.create_order(pair: "bito_eth", action: "buy", amount: "600", price: "0.000001", type: "limit")
    def create_order(pair: "", action: "", amount: 0, price: 0, type: "limit")
      authenticated_post("/orders/#{pair}", { body: { action: action,
                                                      amount: amount,
                                                      price: price,
                                                      timestamp: timestamp,
                                                      type: type }})
    end
  end
end
