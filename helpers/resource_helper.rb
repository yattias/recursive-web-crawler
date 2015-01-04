module ResourceHelper

  def extract_stylesheets(doc)
    stylesheets = []
    doc.css("link").each do |resource_obj|
      r = resource_obj.attr("href") if stylesheet?(resource_obj)
      stylesheets << r if !r.nil? && !stylesheets.include?(r)
    end
    stylesheets
  end

  def extract_scripts(doc)
    scripts = []
    doc.css("script").each do |resource_obj|
      r = resource_obj.attr("src")
      scripts << r if !r.nil? && !scripts.include?(r)
    end
    scripts
  end

  def extract_images(doc)
    images = []
    doc.css("img").each do |resource_obj|
      r = resource_obj.attr("src")
      images << r if !r.nil? && !images.include?(r)
    end
    images
  end  

  def stylesheet?(resource_obj)
    resource_obj.attr("rel") == "stylesheet"   
  end
end
