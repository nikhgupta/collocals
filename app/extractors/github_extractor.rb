class GithubExtractor < Extractor::Base
  def name
    auth["info"]["name"]
  end

  def username
    auth["info"]["nickname"]
  end

  def email
    auth["info"]["email"]
  end

  def image
    auth["info"]["image"]
  end

  def url
    auth["info"]["urls"]["GitHub"]
  end

  def credentials
    super.merge token: auth["credentials"]["token"]
  end
end
