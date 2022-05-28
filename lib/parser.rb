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

  private

  attr_reader :file_path, :view_class

  def add_to_views(line)
    url, ip_address = line.split
    @views << view_class.new(url, ip_address)
  end
end
