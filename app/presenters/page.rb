class Page
  include Concerns::Pages::ViewContext

  def render_collection(collection, view_path, **local_assigns, &block)
    local_assigns ||= {}
    collection.map do |item|
      yield(local_assigns, item)
      render view_path, local_assigns
    end.join.html_safe
  end
end
