module LinkHelper
  def build_absolute_url(rel_url, domain_url)    
    pieces = URI.split(domain_url)
    (pieces[0] || "http") + "://" + pieces[2] + rel_url           
  end

  def same_domain?(url, domain_url)
    URI.parse(url).host.gsub("www.", "") == URI.parse(domain_url).host.gsub("www.", "")
  end

  def add_url_protocol(url)
    unless url[/\Ahttp:\/\//] || url[/\Ahttps:\/\//]
      url = "http://#{url}"
    end
    url
  end

  def relative_url?(url)
    url[0] == "/"
  end

  def normalize_url(url, domain_url = nil)       
      url = build_absolute_url(url, domain_url) if relative_url?(url) && domain_url
      add_url_protocol(url)      
  end
end