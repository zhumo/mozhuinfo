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

      def render_pings_list
        render "pings/list", list: pings_list
      end

      def new_ping_link
        link_to "New Ping", route_path(:new_user_ping, user), class: 'button'
      end

      def edit_user_link
        link_to 'Edit', user.edit_path
      end

      def users_index_link
        link_to 'All Users', view_context.users_path
      end

      def pings
        @pings ||= user.pings.map do |pm_record|
          Exhibit.exhibit_for(view_context, pm_record)
        end
      end

      private

      def pings_list
        @pings_list ||= Pages::Pings::List.new(view_context, user_record)
      end
    end
  end
end
