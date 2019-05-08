require "spec_helper"

RSpec.describe Bitopro::Client do
  describe "#order_book" do
    subject { Bitopro::Client.new.order_book(currency_pair) }

    context "when currency pair is empty" do
      let(:currency_pair) { nil }

      it { is_expected_block.to raise_error Bitopro::Public::Error }
    end

    context "when api succeeds" do
      let(:currency_pair) { "btc_twd" }
      let!(:request_stub) do
        stub_request(:get, "#{Bitopro::BASE_URL}/order-book/#{currency_pair}")
          .to_return(status: 200, body: json_fixture('order-book'))
      end

      it "return parsed json order book" do
        subject
        expect(request_stub).to have_been_requested
      end
    end
  end

  describe "#tickers" do
    subject { Bitopro::Client.new.tickers(currency_pair) }

    context "when api succeeds" do
      let(:currency_pair) { "btc_twd" }
      let!(:request_stub) do
        stub_request(:get, "#{Bitopro::BASE_URL}/tickers/#{currency_pair}")
          .to_return(status: 200, body: json_fixture('tickers'))
      end

      it "return parsed json order book" do
        subject
        expect(request_stub).to have_been_requested
      end
    end
  end

  describe "#recent_trades" do
    subject { Bitopro::Client.new.recent_trades(currency_pair) }

    context "when currency pair is empty" do
      let(:currency_pair) { nil }

      it { is_expected_block.to raise_error Bitopro::Public::Error }
    end

    context "when api succeeds" do
      let(:currency_pair) { "btc_twd" }
      let!(:request_stub) do
        stub_request(:get, "#{Bitopro::BASE_URL}/trades/#{currency_pair}")
          .to_return(status: 200, body: json_fixture('recent_trades'))
      end

      it "return parsed json order book" do
        subject
        expect(request_stub).to have_been_requested
      end
    end
  end
end
