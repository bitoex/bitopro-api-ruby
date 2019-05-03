require "spec_helper"

RSpec.describe Bitopro::Client do
  describe "#order_book" do
    let(:currency_pair) { "btc_twd" }

    subject { Bitopro::Client.new.order_book(currency_pair) }

    context "when currency pair is empty" do

    end

    context "when api responds with error" do

    end

    context "when api succeeds" do
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
end
