require_relative 'view'

class Parser

  def initialize(file_path, view_class: View)
    @file_path = file_path
    @view_class = view_class
    @views = []
  end

  def convert_file
    File.foreach(file_path) { |line| add_to_views(line) }
  end

  def views
    @views.dup
  end

  def list_views
    convert_file
    convert_to_string(ordered_tallied_urls)
  end

  private

  attr_reader :file_path, :view_class

  def add_to_views(line)
    url, ip_address = line.split
    @views << view_class.new(url, ip_address)
  end

  def ordered_tallied_urls
    @views.map(&:url).tally.sort_by(&:last).reverse
  end

  def convert_to_string(array)
    array.map { |view| "#{view[0]} #{view[1]} views" }.join("\n")
  end
end
