module Pages
  module Pings
    class List < Page

      attr_reader :user_record

      def initialize(view_context, user_record)
        initialize_view_context(view_context)
        @user_record = user_record
      end

      def render_ping_rows
        render partial: 'pings/row', collection: pings, as: :ping, locals: { list: self }
      end

      def link_to_edit(ping)
        link_to "✍️", [:edit, @user_record, ping] , title: "Edit"
      end

      def link_to_delete(ping)
        link_to "🗑", [@user_record, ping], title: "Delete", method: :delete
      end

      def ping_records
        @ping_record ||= user_record.pings
      end

      def pings
        @pings ||= ping_records.map do |pm_record|
          Exhibit.exhibit_for(view_context, pm_record)
        end
      end
    end
  end
end
