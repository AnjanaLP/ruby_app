class Formatter
  DIVIDER = "\n---------------------------------\n"

  def display_all(views)
    header("All") + display(views) + DIVIDER
  end

  def display_unique(views)
    header("Unique") + display(views, "unique" + " ")
  end

  private

  def header(view_type)
    "#{view_type} page views (descending):\n"
  end

  def display(views, view_type = nil)
    views.map do |view|
      view[1] != 1 ? "#{view[0]} #{view[1]} #{view_type}views" : "#{view[0]} #{view[1]} #{view_type}view"
    end.join("\n")
  end
end
