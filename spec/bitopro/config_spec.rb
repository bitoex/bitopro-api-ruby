require "spec_helper"

RSpec.describe Bitopro::Config do
  describe ".configure" do
    before do
      described_class.instance = described_class.new
    end

    it "makes Bitopro configured" do
      expect(Bitopro).not_to be_configured

      Bitopro.configure do |config|
        config.email = "bitopro@ruby.rspec"
        config.key = "1"
        config.secret = "2"
      end

      expect(Bitopro).to be_configured
    end
  end
end
