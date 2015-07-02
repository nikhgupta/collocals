class FoursquareExtractor < Extractor::Base

  def name
    auth["info"]["name"]
  end

  def username; end

  def email
    auth["info"]["email"]
  end

  def image
    "#{auth["info"]["image"]["prefix"]}128x128#{auth["info"]["image"]["suffix"]}"
  end

  def credentials
    super.merge token: auth["credentials"]["token"]
  end

  def url
    "https://foursquare.com/user/#{auth['uid']}"
  end

  def gender
    auth["extra"]["raw_info"]["gender"]
  end
end
