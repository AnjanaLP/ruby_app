require_relative 'view'
require_relative 'formatter'

class Parser
  def initialize(file_path, view_class: View, formatter: Formatter.new)
    @file_path = file_path
    @view_class = view_class
    @formatter = formatter
    @all_views = []
  end

  def convert_file
    File.foreach(file_path) { |line| add_to_all_views(line) }
  end

  def list_all_views
    formatter.display_all(sorted_views(all_views))
  end

  def list_unique_views
    formatter.display_unique(sorted_views(unique_views))
  end

  private

  attr_reader :file_path, :view_class, :formatter, :all_views

  def add_to_all_views(line)
    url, ip_address = line.split
    all_views << view_class.new(url, ip_address)
  end

  def sorted_views(views)
    views.map(&:url).tally.sort_by(&:last).reverse
  end

  def unique_views
    all_views.uniq { |view| [ view.url, view.ip_address ] }
  end
end
