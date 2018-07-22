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

      def show_link_with_name(user)
        link_to user.name, user
      end

      def user_destroy_link(user)
        link_to user, method: :delete, title: "Delete", data: { confirm: 'Are you sure?' } do
          "x"
        end
      end

      def new_user_button
        link_to 'New User', view_context.new_user_path, class: "button button--blank"
      end
    end
  end
end
