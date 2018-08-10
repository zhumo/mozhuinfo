module Pages
  module Pings
    class List < Page

      attr_reader :contact_record

      def initialize(view_context, contact_record)
        initialize_view_context(view_context)
        @contact_record = contact_record
      end

      def render_ping_rows
        render partial: 'pings/row', collection: pings, as: :ping, locals: { list: self }
      end

      def link_to_edit(ping)
        link_to "✍️", [:edit, @contact_record, ping] , title: "Edit"
      end

      def link_to_delete(ping)
        link_to "🗑", [@contact_record, ping], title: "Delete", method: :delete
      end

      def ping_records
        @ping_record ||= contact_record.pings
      end

      def pings
        @pings ||= ping_records.map do |pm_record|
          Exhibit.exhibit_for(view_context, pm_record)
        end
      end
    end
  end
end
