module Concerns
  module Pages
    module ViewContext
      include Concerns::ViewContext

      delegate :link_to, :render, :form_for,
        :authorized_blog_scope, :authorized_user_scope,
        to: :view_context
    end
  end
end
