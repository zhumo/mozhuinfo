module Concerns
  module Pages
    module ViewContext
      include Concerns::ViewContext

      delegate :link_to, :render, :form_for, to: :view_context
    end
  end
end
