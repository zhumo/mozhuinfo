module Concerns
  module AuthorizedScopes
    extend ActiveSupport::Concern

    included do
      helper_method :authorized_blog_scope
    end

    def authorized_blog_scope
      scope = Blog.all
      unless authenticated?
        scope = scope.published
      end
      scope
    end
  end
end
