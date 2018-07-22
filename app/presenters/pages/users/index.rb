module Pages
  module Users
    class Index < Page

      def initialize(view_context)
        initialize_view_context(view_context)
      end

      def render_user_rows
        render partial: "users/row", collection: users, as: :user, locals: { page: self }
      end

      def users
        @users ||= authorized_user_scope.map {|user| Exhibit.exhibit_for(view_context, user) }
      end

      def user_show_link(user)
        link_to 'Show', user
      end

      def user_edit_link(user)
        link_to 'Edit', user.edit_path
      end

      def user_destroy_link(user)
        link_to 'Destroy', user, method: :delete, data: { confirm: 'Are you sure?' }
      end

    end
  end
end
