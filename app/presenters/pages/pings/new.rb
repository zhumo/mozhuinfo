module Pages
  module Pings
    class New < Page

      attr_reader :contact_record

      def initialize(view_context, contact_record)
        initialize_view_context(view_context)
        @contact_record = contact_record
      end

      def contact
        @contact ||= Exhibit.exhibit_for(view_context, contact_record)
      end

      def render_ping_form
        render "form", form: form
      end

      def link_to_contact
        link_to "Back", contact
      end

      def after_create_path
        contact
      end

      private

      delegate :save, to: :form
      alias create save
      def form
        @form ||= Pages::Pings::Form.new(view_context, contact_record)
      end

      def ping_record
        @ping_record ||= contact_record.pings.new
      end

      def ping
        @ping ||= Exhibit.exhibit_for(view_context, ping_record)
      end
    end
  end
end
