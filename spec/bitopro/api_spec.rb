require "spec_helper"

RSpec.describe Bitopro do
  it "has a version number" do
    expect(Bitopro::VERSION).not_to be nil
  end

  describe ".configure" do
    before do
      Bitopro::Config.instance = Bitopro::Config.new
    end

    it "makes Bitopro configured" do
      expect(described_class).not_to be_configured

      described_class.configure do |config|
        config.email = "bitopro@ruby.rspec"
        config.key = "1"
        config.secret = "2"
      end

      expect(described_class).to be_configured
    end
  end

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
