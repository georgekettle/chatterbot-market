module UrlHelper
  def full_url(url)
    uri = URI.parse(url)
    if uri.scheme.nil?
      url = "http://#{url}"
    end
    url
  end

  def naked_url(url)
    url = URI.parse(url).host || url
    url.start_with?('www.') ? url[4..-1] : url
  end
end