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

    # Example:
    # client = Bitopro::Client.new
    # client.cancel_order(pair: "bito_eth", order_id: "3135725012")
    def cancel_order(pair: "", order_id: "")
      authenticated_delete("/orders/#{pair}/#{order_id}")
    end

    def get_order(pair: "", order_id: "")
      authenticated_get("/orders/#{pair}/#{order_id}")
    end
  end
end
