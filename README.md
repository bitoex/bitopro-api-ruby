# Bitopro

[![Build Status](https://travis-ci.org/niclin/bitopro.svg?branch=master)](https://travis-ci.org/niclin/bitopro)
[![Gem Version](https://badge.fury.io/rb/bitopro.svg)](https://badge.fury.io/rb/bitopro)

This is an unofficial Ruby wrapper for the Bitopro exchange APIs.

[Bitopro official API document](https://developer.bitopro.com/docs)

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'bitopro'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install bitopro

## Setup

Set account credentials if you want use authentication API endpoint.

```ruby
Bitopro.configure do |config|
  config.email = "your_email"
  config.key = "your_key"
  config.secret = "your_secret"
end
```

## Usage

```ruby
require "bitopro"

client = Bitopro::Client.new

# Get order book
client.order_book("btc_twd")
# {"asks"=>[{"amount"=>"0.00088542", "count"=>1, "price"=>"161986", "total"=>"0.00088542"}}

# Create an order
client.create_order(pair: "bito_eth", action: "buy", amount: "600", price: "0.000001", type: "limit")
# {"orderId"=>"7520016984", "timestamp"=>1555576726000, "action"=>"BUY", "amount"=>"600", "price"=>"0.000001"}

# Get an order
client.get_order(pair: "bito_eth", order_id: "")
# {"id"=>"7520016984", "pair"=>"bito_eth", "price"=>"0.00000100", "avgExecutionPrice"=>"0.00000000", "action"=>"buy", "type"=>"limit", "timestamp"=>1555576726000, "status"=>0, "originalAmount"=>"600.00000000", "remainingAmount"=>"600.00000000", "executedAmount"=>"0.00000000", "fee"=>"0.00000000", "feeSymbol"=>"BITO", "bitoFee"=>"0.00000000"}

# Cancel an order
client.cancel_order(pair: "bito_eth", order_id: "3135725012")
# {"orderId"=>"7520016984", "action"=>"BUY", "timestamp"=>1555576884000, "price"=>"0.000001", "amount"=>"600"}
```

## Available Events

#### Public

- `#order_book(pair)`
- `#ticker(pair)`
- `#recent_trades(pair)`

#### Authenticated

- `#account_balance`
- `#order_history`
- `#order_list(pair: STRING, page: INTEGER, active: BOOLEAN)`
- `#create_order(pair: STRING, action: "buy or sell", amount: INTEGER, price: INTEGER, type: "limit or market")`
- `#cancel_order(pair: STRING, order_id: STRING)`
- `#get_order(pair: STRING, order_id: STRING)`

## Development

After checking out the repo, run `bin/setup` to install dependencies. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/niclin/bitopro. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).


