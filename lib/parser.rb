require_relative 'view'
require_relative 'formatter'

class Parser

  def initialize(file_path, view_class: View, formatter: Formatter.new)
    @file_path = file_path
    @view_class = view_class
    @formatter = formatter
    @views = []
  end

  def convert_file
    File.foreach(file_path) { |line| add_to_views(line) }
  end

  def list_all_views
    formatter.display_all(ordered_tallied_urls(views))
  end

  def list_unique_views
    formatter.display_unique(ordered_tallied_urls(unique_views))
  end

  private

  attr_reader :file_path, :view_class, :views, :formatter

  def add_to_views(line)
    url, ip_address = line.split
    views << view_class.new(url, ip_address)
  end

  def ordered_tallied_urls(views)
    views.map(&:url).tally.sort_by(&:last).reverse
  end

  def unique_views
    views.uniq { |view| [ view.url, view.ip_address ] }
  end
end
