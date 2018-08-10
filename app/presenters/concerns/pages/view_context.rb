module Concerns
  module Pages
    module ViewContext
      include Concerns::ViewContext

      delegate :link_to, :render, :form_for,
        :authorized_blog_scope, :authorized_contact_scope,
        :options_for_select,
        to: :view_context
    end
  end
end
