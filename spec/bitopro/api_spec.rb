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

      described_class.configure do |c|
        c.key = 1
        c.secret = '2'
      end

      expect(described_class).to be_configured
    end
  end
end
