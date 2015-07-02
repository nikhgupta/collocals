class LinkedinExtractor < Extractor::Base

  def name
    auth["info"]["name"]
  end

  # linkedin has no concept of usernames
  def username; end

  def email
    auth["info"]["email"]
  end

  def image
    auth["info"]["image"]
  end

  def credentials
    cred = auth["credentials"]
    super.merge token: cred["token"], expires_at: cred["expires_at"]
  end

  def url
    auth["info"]["urls"]["public_profile"]
  end
end
