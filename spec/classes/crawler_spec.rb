require_relative '../../classes/crawler'
require 'open-uri'

RSpec.configure do |config|
  config.mock_framework = :mocha
end

describe Crawler do
  
  before(:each) do
    @crawler = Crawler.new
    @page_url = @domain = "http://www.test.com"
    @doc = mock("NokogiriDocTestDouble")
    
    
  end

  describe ".extract_links" do
    it "should normalize link" do       
      link_objects = get_mock_links
      @doc.expects(:css).once.with("a").returns(link_objects)
      Crawler.any_instance.expects(:normalize_url).times(2)
      
      @crawler.send(:extract_links, @doc, @page_url)
    end

    it "should check for same domain" do
      link_objects = get_mock_links
      @doc.expects(:css).once.with("a").returns(link_objects)
      Crawler.any_instance.expects(:same_domain?).times(link_objects.length)
      
      @crawler.send(:extract_links, @doc, @page_url)
    end

    it "should skip link when an exception is raised" do
      bad_link_objects = get_bad_mock_links
      @doc.expects(:css).once.with("a").returns(bad_link_objects)

      result = @crawler.send(:extract_links, @doc, @page_url)
      expect(result).to match_array([bad_link_objects.first.attr("href")])
    end

    it "should return a list of links iff they meet criteria" do
      link_objects = get_mock_links
      @doc.expects(:css).once.with("a").returns(link_objects)
      
      Crawler.any_instance.expects(:same_domain?).times(link_objects.length).with(anything, anything).returns(true)
      Crawler.any_instance.expects(:normalize_url).once.with(link_objects[0].attr("href")).returns(link_objects[0].attr("href"))

      # expect_any_instance_of(Crawler).to receive(:normalize_url).exactly(1).with(link_objects[1].attr("href"), anything).and_return(link_objects[1].attr("href"))

      result = @crawler.send(:extract_links, @doc, @page_url)
    end
  end

  def get_mock_links
    link1 = mock("NokogiriLinkTestDouble")
    link2 = mock("NokogiriLinkTestDouble")
    link1.stubs(:attr).with("href").returns("#{@domain}/link1")          
    link2.stubs(:attr).with("href").returns("#{@domain}/link2")
    [link1, link2]
  end

  def get_bad_mock_links
    link1 = mock("NokogiriLinkTestDouble")
    link2 = mock("NokogiriLinkTestDouble")
    link1.stubs(:attr).with("href").returns("#{@domain}/link1")          
    link2.stubs(:attr).with("href").returns("I will raise an exception")
    [link1, link2]
  end

end