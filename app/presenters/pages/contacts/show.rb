module Pages
  module Contacts
    class Show < Page

      attr_accessor :contact_record

      def initialize(view_context, contact_record)
        initialize_view_context(view_context)
        @contact_record = contact_record
      end

      def contact
        @contact ||= Exhibit.exhibit_for(view_context, contact_record)
      end

      def render_pings_list
        render "pings/list", list: pings_list
      end

      def new_ping_link
        link_to "New Ping", route_path(:new_contact_ping, contact), class: 'button'
      end

      def edit_contact_link
        link_to 'Edit', contact.edit_path
      end

      def contacts_index_link
        link_to 'All Contacts', view_context.contacts_path
      end

      def pings
        @pings ||= contact.pings.map do |pm_record|
          Exhibit.exhibit_for(view_context, pm_record)
        end
      end

      private

      def pings_list
        @pings_list ||= Pages::Pings::List.new(view_context, contact_record)
      end
    end
  end
end
