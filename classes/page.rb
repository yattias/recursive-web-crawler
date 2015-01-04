class Page  

  def initialize(url, sub_links, resources)
    @url = url
    @sub_links = sub_links
    @resources = resources
    @children = []
  end

  def set_tree_renderer(tree_renderer)
    @tree_renderer = tree_renderer
  end

  def get_sub_links
    @sub_links
  end

  def get_url
    @url
  end

  def get_resources
    @resources
  end

  def add_child(page)
    @children << page
  end

  def get_children
    @children
  end

  def get_binding
    binding
  end

end