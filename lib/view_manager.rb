require_relative 'view'

class ViewManager
  def initialize(view_class: View)
    @view_class = view_class
    @all_views = []
  end

  def add_view(url, ip_address)
    all_views << view_class.new(url, ip_address)
  end

  def sort_views(type = nil)
    type ? descend_order(tally_urls(unique_views)) : descend_order(tally_urls(all_views))
  end

  private

  attr_reader :view_class, :all_views

  def unique_views
    all_views.uniq { |view| [ view.url, view.ip_address ] }
  end

  def descend_order(views)
    views.sort_by(&:last).reverse
  end

  def tally_urls(views)
    views.map(&:url).tally
  end
end
