require 'rails_helper'
require 'extractor/base'

describe Extractor::Base do
  it "returns class name for a given provider" do
    expect(described_class.class_for("facebook")).to eq(FacebookExtractor)
    expect{described_class.class_for("not_exists")}.to raise_error(
      RuntimeError, "NotExist is not a valid extractor!")
  end

  it "loads extractor for a given provider from omniauth data" do
    auth = OmniAuth.config.mock_auth[:facebook]
    response = described_class.load(auth)
    expect(response).to be_a(FacebookExtractor)
    expect(response.uid).to eq("12345")
  end
end
