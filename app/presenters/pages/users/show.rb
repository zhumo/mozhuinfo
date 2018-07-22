module Pages
  module Users
    class Show < Page

      attr_accessor :user_record

      def initialize(view_context, user_record)
        initialize_view_context(view_context)
        @user_record = user_record
      end

      def user
        @user ||= Exhibit.exhibit_for(view_context, user_record)
      end

      def edit_user_link
        link_to 'Edit', user.edit_path
      end

      def users_index_link
        link_to 'All Users', view_context.users_path
      end
    end
  end
end
