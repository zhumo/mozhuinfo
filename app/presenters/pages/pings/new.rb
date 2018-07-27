module Pages
  module Pings
    class New < Page

      attr_reader :user_record

      def initialize(view_context, user_record)
        initialize_view_context(view_context)
        @user_record = user_record
      end

      def user
        @user ||= Exhibit.exhibit_for(view_context, user_record)
      end

      def render_ping_form
        render "form", form: form
      end

      def link_to_user
        link_to "Back", user
      end

      def after_create_path
        user
      end

      private

      delegate :save, to: :form
      alias create save
      def form
        @form ||= Pages::Pings::Form.new(view_context, user_record)
      end

      def ping_record
        @ping_record ||= user_record.pings.new
      end

      def ping
        @ping ||= Exhibit.exhibit_for(view_context, ping_record)
      end
    end
  end
end