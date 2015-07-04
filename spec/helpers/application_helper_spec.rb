require 'rails_helper'

# Specs in this file have access to a helper object that includes
# the UsersHelper. For example:
#
# describe UsersHelper do
#   describe "string concat" do
#     it "concats two strings with spaces" do
#       expect(helper.concat_strings("this","that")).to eq("this that")
#     end
#   end
# end
RSpec.describe ApplicationHelper, type: :helper do
  describe "#fa_brand_icon" do
    it "produces html for colored brand icon by name" do
      actual = helper.fa_brand_icon('lastfm')
      expect(actual).to have_selector('i.fa.fa-lastfm.fa-lastfm-colored')
    end

    it "produces html for colored brand icon with given size" do
      actual = helper.fa_brand_icon('lastfm', size: 3)
      expect(actual).to have_selector('i.fa.fa-3x')
    end

    it "produces html for colored brand icon with a given fa icon" do
      actual = helper.fa_brand_icon('google', icon: 'google-plus')
      expect(actual).to have_selector('i.fa-google-plus.fa-google-colored')
    end

    it "passes extra options to #fa_icon helper" do
      actual = helper.fa_brand_icon('lastfm', class: "test")
      expect(actual).to have_selector('i.fa-lastfm.test')
    end
  end
  describe "#fa_provider_icon" do
    it "produces html for colored square brand icon for a given provider" do
      actual = helper.fa_provider_icon('facebook')
      expect(actual).to have_selector('i.fa-facebook-square.fa-facebook-colored')
    end

    it "default size for the provider icon is 2x" do
      actual = helper.fa_provider_icon('facebook')
      expect(actual).to have_selector('i.fa.fa-2x')
    end

    it "allows to provide a custom size for the provider icon" do
      actual = helper.fa_provider_icon('facebook', size: 3)
      expect(actual).to have_selector('i.fa.fa-3x')
    end

    it "passes extra options to #fa_brand_icon" do
      actual = helper.fa_provider_icon('lastfm', class: "test")
      expect(actual).to have_selector('i.fa-lastfm-square.test')
    end

    context "google" do
      it "specifies a custom icon" do
        actual = helper.fa_provider_icon('google')
        expect(actual).to have_selector('i.fa-google-plus-square.fa-google-colored')
      end
    end

    context "foursquare" do
      it "specifies a custom icon" do
        actual = helper.fa_provider_icon('foursquare')
        expect(actual).to have_selector('i.fa-foursquare.fa-foursquare-colored')
      end
    end
  end
  describe "#fa_button" do
    it "produces html for icon button for fontawesome icon" do
      actual = helper.fa_button 'lastfm', "/test"
      expect(actual).to have_text('')
      expect(actual).to have_selector("[href='/test']")
      expect(actual).to have_selector('a.btn.btn-block.btn-social.btn-default.btn-action')
      expect(actual).to have_selector('i.fa.fa-2x.fa-lastfm')
    end

    it "produces html for button for fontawesome icon with text" do
      actual = helper.fa_button 'lastfm', "/test", text: "some text"
      expect(actual).to have_text(' some text')
      expect(actual).to have_selector("[href='/test']")
      expect(actual).to have_selector('a.btn.btn-block.btn-social.btn-default.btn-action')
      expect(actual).to have_selector('i.fa.fa-2x.fa-lastfm')
    end
  end
  describe "#fa_provider_button" do
    it "produces html for button icon for provider" do
      actual = helper.fa_provider_button 'google', resource: :user
      expect(actual).to have_text('Sign in with Google')
      expect(actual).to have_selector("[href='/users/auth/google']")
      expect(actual).to have_selector('a.btn.btn-block.btn-social.btn-google')
      expect(actual).to have_selector('a i.fa.fa-2x.fa-google-plus-square.fa-google-colored')
    end

    it "produces html for button for fontawesome icon with text" do
      actual = helper.fa_provider_button 'google', resource: :user, icon: true
      expect(actual).to have_text('')
      expect(actual).to have_selector("[href='/users/auth/google']")
      expect(actual).to have_selector('a.btn.btn-block.btn-social-icon.btn-google')
      expect(actual).to have_selector('a i.fa.fa-2x.fa-google-plus-square.fa-google-colored')
    end
  end
end

