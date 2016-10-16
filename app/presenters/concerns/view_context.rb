module Concerns
  module ViewContext
    attr_reader :view_context

    def initialize_view_context(view_context)
      @view_context = view_context
    end

    def route_path(path_name, *args)
      view_context.send("#{path_name}_path".to_sym, args)
    end
  end
end
