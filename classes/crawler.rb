require_relative '../helpers/link_helper'
require_relative '../helpers/resource_helper'
require_relative 'html_link_tree'
require_relative 'page'

class Crawler

  include LinkHelper
  include ResourceHelper

  def crawl(page_url, depth = 1, parent_page = nil)
    return unless depth > 0

    begin
      doc = Nokogiri::HTML(open(page_url, :allow_redirections => :all))
    rescue Exception => e
      return
    end

    puts "Crawling: #{page_url}, depth: #{depth}..."

    page = build_page(doc, page_url)
    page.get_sub_links.each do |link|
        page.add_child( crawl(link, depth-1, page) )
    end

    return page
  end

  private

  def build_page(doc, page_url)
    links = extract_links(doc, page_url)    
    resources = extract_resources(doc)
    Page.new(page_url, links, resources)
  end

  def extract_links(doc, page_url)
    links = [] 
    doc.css("a").each do |link_obj|
      begin
        link = normalize_url(link_obj.attr("href"), page_url)        
        links << link if ( !links.include?(link) && same_domain?(link, page_url) )
      rescue Exception => e
        next
      end      
    end
    links
  end

  def extract_resources(doc)
    extract_stylesheets(doc).concat(extract_scripts(doc)).concat(extract_images(doc))
  end
end
