module PageRenderHelper

  def self.render(page, site_map_renderer, tree_renderer)
    html = render_tree(page, tree_renderer)
    link_tree = HTMLLinkTree.new(html, page.get_url) 

    site_map_renderer.result(link_tree.get_binding)
  end

  def self.render_tree(page, tree_renderer)
    page.set_tree_renderer(tree_renderer)
    tree_renderer.result(page.get_binding)
  end
end