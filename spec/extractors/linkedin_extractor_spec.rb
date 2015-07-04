require 'rails_helper'

describe LinkedinExtractor do
  let(:auth) { OmniAuth.config.mock_auth[:linkedin] }
  subject{ described_class.new(auth) }
  let(:match) {
    {
      uid: "12345",
      provider: "linkedin",
      name: "Test Linkedin User",
      email: "testuser@linkedin.com",
      image: "http://url.to/profile-image.jpg",
      verified: false,
      username: nil,
      gender: nil,
      timezone_offset: 0,
      url: "https://www.linkedin.com/in/testusername",
      language: nil,
      credentials: {
        token: "some-token" * 100,
        refresh_token: nil,
        secret: nil,
        expires_at: auth['credentials']['expires_at']
      }
    }
  }

  it "has a reauth_hash that can be used to supply parameters when reauthenticating" do
    expect(described_class.reauth_hash).to be_empty
  end

  it "extracts data from omniauth data" do
    %w[uid provider name email image verified username gender
       timezone_offset url language credentials].each do |field|
      message  = "expected value of #{field}: #{subject.send(field).inspect}\n"
      message += "#{" " * (field.length + 15)}got: #{match[field.to_sym].inspect}"
      expect(subject.send(field)).to eq(match[field.to_sym]), message
    end
  end

  it "has a signature method which can uniquely identity this identity" do
    expect(subject.signature).to eq(uid: match[:uid], provider: match[:provider])
  end

  it "has attributes_data method that returns extracted data as a Hash" do
    match.merge!(match.delete(:credentials))
    expect(subject.attributes_data).to eq(match)
  end
end

