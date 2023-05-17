module UrlHelper
  def full_url(url)
    uri = URI.parse(url)
    if uri.scheme.nil?
      url = "http://#{url}"
    end
    url
  end
end