require "spec_helper"

RSpec.describe Bitopro::Api do
  it "has a version number" do
    expect(Bitopro::Api::VERSION).not_to be nil
  end
end
