# Bitopro

[![Build Status](https://travis-ci.org/niclin/bitopro.svg?branch=master)](https://travis-ci.org/niclin/bitopro)
[![Gem Version](https://badge.fury.io/rb/bitopro.svg)](https://badge.fury.io/rb/bitopro)

This is an Ruby wrapper for the Bitopro exchange APIs.

[Bitopro official API document](https://developer.bitopro.com/docs)

- [Installation](#installation)
- [Getting started](#setup)
- [Public REST Endpoints](#public-rest-endpoints)
  - [getOrderBook](#getorderbook)
  - [getTickers](#gettickers)
  - [getTrades](#gettrades)
- [Authenticated REST Endpoints](#authenticated-rest-endpoints)
  - [getAccountBalances](#getaccountbalances)
  - [getOrderHistory](#getorderhistory)
  - [getOrders](#getorders)
  - [createOrder](#createorder)
  - [cancelOrder](#cancelorder)

## Rate Limit

| Types | Rate Limit |
|---|---|
|  Public API | 600 requests per minute per IP |
|  Authenticated API | 600 requests per minute per IP/600 requests per minute per user|

### Precisions

#### Price precision

The tick size of all pairs is 0.00000001, which means you can trade all pairs only for prices that are a multiple of 0.00000001. For example, you could place a buy BTC/TWD order at price 180,070.12345678. but you will fail to open an order at price 180,070.123456789.

#### Amount precision

The same as price precision but you should be aware the [minimum order amount](#minimum-order-amount).

### Minimum order amount

Checkout the [official settings](https://www.bitopro.com/fees) of minimum amount.

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
```



### Public REST Endpoints

#### getOrderBook

```ruby
client.order_book("btc_twd")
```

<details>
<summary>Output</summary>

```json
{
  "bids": [
    {
      "price": "180500",
      "amount": "0.12817687",
      "count": 1,
      "total": "0.12817687"
    },
    {
      "price": "180010",
      "amount": "0.32292",
      "count": 2,
      "total": "0.45109687"
    },
    {
      "price": "180000",
      "amount": "0.24236",
      "count": 3,
      "total": "0.69345687"
    }
  ],
  "asks": [
    {
      "price": "180599",
      "amount": "0.00326056",
      "count": 1,
      "total": "0.00326056"
    },
    {
      "price": "180600",
      "amount": "0.04202575",
      "count": 1,
      "total": "0.04528631"
    }
  ]
}
```
</details>

#### getTickers

```ruby
client.tickers("eth_btc")
```

<details>
<summary>Output</summary>

```json
{
  "data": [
    {
      "high24hr": "0.03252800",
      "isBuyer": false,
      "lastPrice": "0.03252800",
      "low24hr": "0.03252800",
      "pair": "eth_btc",
      "priceChange24hr": "0",
      "volume24hr": "0.00000000"
    },
    {
      "high24hr": "541.00000000",
      "isBuyer": false,
      "lastPrice": "541.00000000",
      "low24hr": "541.00000000",
      "pair": "btg_twd",
      "priceChange24hr": "0",
      "volume24hr": "0.00000000"
    }
  ]
}
```

</details>

#### getTrades

```ruby
client.recent_trades("btc_twd")
```

<details>
<summary>Output</summary>

```json
{
  "data": [
    {
      "timestamp": 1557203407,
      "price": "180500.00000000",
      "amount": "0.07717687",
      "isBuyer": false
    },
    {
      "timestamp": 1557203187,
      "price": "180500.00000000",
      "amount": "0.05100000",
      "isBuyer": false
    },
    {
      "timestamp": 1557203053,
      "price": "180500.00000000",
      "amount": "0.01860000",
      "isBuyer": false
    },
    {
      "timestamp": 1557202804,
      "price": "180500.00000000",
      "amount": "0.04781533",
      "isBuyer": false
    },
    {
      "timestamp": 1557202804,
      "price": "180500.00000000",
      "amount": "0.06000000",
      "isBuyer": false
    }
  ]
}
```

</details>

### Authenticated REST Endpoints

#### getAccountBalances

```ruby
client.account_balance
```

<details>
<summary>Output</summary>

```json
{
  "data": [
    {
      "amount": "10001",
      "available": "1.0",
      "currency": "bito",
      "stake": "10000"
    },
    {
      "amount": "0.0",
      "available": "1.0",
      "currency": "btc",
      "stake": "0"
    },
    {
      "amount": "3.0",
      "available": "0.01",
      "currency": "eth",
      "stake": "0"
    },
    {
      "amount": "30000",
      "available": "2500",
      "currency": "twd",
      "stake": "0"
    }
  ]
}
```

</details>

#### getOrderHistory

```ruby
client.order_history
```

<details>
<summary>Output</summary>

```json
{
  "data": [
    {
      "action": "buy",
      "avgExecutionPrice": "100000.00000000",
      "bitoFee": "0.00000000",
      "executedAmount": "1.00000000",
      "fee": "0.00100000",
      "feeSymbol": "BTC",
      "id": "123",
      "originalAmount": "1.00000000",
      "pair": "btc_twd",
      "price": "100000.00000000",
      "remainingAmount": "0.00000000",
      "status": 2,
      "timestamp": 1508753757000,
      "type": "limit"
    },
    {
      "action": "buy",
      "avgExecutionPrice": "100000.00000000",
      "bitoFee": "0.00000000",
      "executedAmount": "1.00000000",
      "fee": "0.00200000",
      "feeSymbol": "BTC",
      "id": "456",
      "originalAmount": "1.00000000",
      "pair": "btc_twd",
      "price": "100000.00000000",
      "remainingAmount": "0.00000000",
      "status": 2,
      "timestamp": 1508753787000,
      "type": "limit"
    }
  ]
}
```

</details>

#### getOrders

```ruby
client.order_list(pair: "btc_twd", page: 1, active: false)
```

<details>
<summary>Output</summary>

```json
{
  "data": [
    {
      "action": "buy",
      "avgExecutionPrice": "100000.00000000",
      "bitoFee": "0.00000000",
      "executedAmount": "1.00000000",
      "fee": "0.00100000",
      "feeSymbol": "BTC",
      "id": "123",
      "originalAmount": "1.00000000",
      "pair": "btc_twd",
      "price": "100000.00000000",
      "remainingAmount": "0.00000000",
      "status": 2,
      "timestamp": 1508753757000,
      "type": "limit"
    },
    {
      "action": "buy",
      "avgExecutionPrice": "100000.00000000",
      "bitoFee": "0.00000000",
      "executedAmount": "1.00000000",
      "fee": "0.00200000",
      "feeSymbol": "BTC",
      "id": "456",
      "originalAmount": "1.00000000",
      "pair": "btc_twd",
      "price": "100000.00000000",
      "remainingAmount": "0.00000000",
      "status": 2,
      "timestamp": 1508753787000,
      "type": "limit"
    }
  ],
  "page": 1,
  "totalPages": 10
}
```

</details>

#### createOrder

```ruby
client.create_order(pair: "btc_twd", action: "buy", amount: 0, price: 0, type: "limit")
```

<details>
<summary>Output</summary>

```json
{
  "action": "buy",
  "amount": "0.235",
  "orderId": "11233456",
  "price": "1.0",
  "timestamp": 1504262258000
}
```

</details>

#### cancelOrder

```ruby
client.cancel_order(pair: "btc_twd", order_id: "12234566")
```

<details>
<summary>Output</summary>

```json
{
  "action": "buy",
  "amount": 2.3,
  "orderId": "12234566",
  "price": 1.2,
  "timestamp": 1504262258000
}
```

</details>

#### getOrder

```ruby
client.get_order(pair: "btc_twd", order_id: "123")
```

<details>
<summary>Output</summary>

```json
{
  "action": "sell",
  "avgExecutionPrice": "112000.00000000",
  "bitoFee": "103.70370360",
  "executedAmount": "1.00000000",
  "fee": "0.00000000",
  "feeSymbol": "TWD",
  "id": "123",
  "originalAmount": "1.00000000",
  "pair": "btc_twd",
  "price": "112000.00000000",
  "remainingAmount": "0.00000000",
  "status": 2,
  "timestamp": 1508753757000,
  "type": "limit"
}
```

</details>

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/bitoex/bitopro-api-ruby. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.

1. Fork it
2. Create your feature branch (```git checkout -b my-new-feature```).
3. Commit your changes (```git commit -am 'Added some feature'```)
4. Push to the branch (```git push origin my-new-feature```)
5. Create new Pull Request

We're using RSpec for testing. Run the test suite with ```rake spec```. Tests for pull requests are appreciated but not required. (If you don't include a test, we'll write one before merging.)

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
