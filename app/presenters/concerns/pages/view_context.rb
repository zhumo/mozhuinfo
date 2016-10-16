module Concerns
  module Pages
    module ViewContext
      include Concerns::ViewContext

      delegate :link_to, to: :view_context
    end
  end
end
