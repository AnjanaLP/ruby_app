require_relative 'view_manager'
require_relative 'formatter'

class Parser
  def initialize(file_path, view_manager: ViewManager.new, formatter: Formatter.new)
    @file_path = file_path
    @view_manager = view_manager
    @formatter = formatter
  end

  def convert_file
    File.foreach(file_path) do |line|
      url, ip_address = line.split
      view_manager.add_view(url, ip_address)
    end
  end

  def list_all_views
    formatter.display_all(view_manager.sort_views)
  end

  def list_unique_views
    formatter.display_unique(view_manager.sort_views(:unique))
  end

  private
  attr_reader :file_path, :view_manager, :formatter
end
