# Bitopro

[![Build Status](https://travis-ci.org/niclin/bitopro.svg?branch=master)](https://travis-ci.org/niclin/bitopro)
[![Gem Version](https://badge.fury.io/rb/bitopro.svg)](https://badge.fury.io/rb/bitopro)

This is an unofficial Ruby wrapper for the Bitopro exchange APIs.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'bitopro'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install bitopro

## Usage

```ruby
require "bitopro"

Bitopro.order_book("btc_twd")

#  => {"asks"=>[{"amount"=>"0.00088542", "count"=>1, "price"=>"161986", "total"=>"0.00088542"}}
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/[USERNAME]/bitopro. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
