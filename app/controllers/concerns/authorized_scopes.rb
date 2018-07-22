module Concerns
  module AuthorizedScopes
    extend ActiveSupport::Concern

    included do
      helper_method :authorized_blog_scope
      helper_method :authorized_user_scope
    end

    def authorized_blog_scope
      scope = Blog.all
      unless authenticated?
        scope = scope.published
      end
      scope
    end

    def authorized_user_scope
      scope = User.all
      unless authenticated?
        scope = scope.none
      end
      scope
    end
  end
end
