module Concerns
  module AuthorizedScopes
    extend ActiveSupport::Concern

    included do
      helper_method :authorized_blog_scope
      helper_method :authorized_contact_scope
    end

    def authorized_blog_scope
      scope = Blog.all
      unless authenticated?
        scope = scope.published
      end
      scope
    end

    def authorized_contact_scope
      scope = Contact.all
      unless authenticated?
        scope = scope.none
      end
      scope
    end
  end
end
