require 'nokogiri'
require 'open-uri'
require 'openssl'
require 'erb'
require 'open_uri_redirections'

require_relative 'helpers/page_render_helper'
require_relative 'classes/crawler'

task :crawl, [:site, :depth] do|t, args|
  OpenSSL::SSL::VERIFY_PEER = OpenSSL::SSL::VERIFY_NONE

  #Create renderers since we don't have rails
  site_map_tmpl = File.read(File.dirname(__FILE__) + "/views/site_map.erb")
  tree_tmpl = File.read(File.dirname(__FILE__) + "/views/partials/page_tree.erb")
  site_map_renderer = ERB.new(site_map_tmpl)
  tree_renderer = ERB.new(tree_tmpl)

  #Crawl + render
  c = Crawler.new
  page = c.crawl(args[:site], args[:depth].to_i)
  html = PageRenderHelper::render(page, site_map_renderer, tree_renderer)

  #Output to file
  File.open("sitemap.html", 'w') { |file| file.write(html) }
end
