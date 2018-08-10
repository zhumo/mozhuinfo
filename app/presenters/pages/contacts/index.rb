module Pages
  module Contacts
    class Index < Page

      def initialize(view_context)
        initialize_view_context(view_context)
      end

      def render_contact_rows
        render partial: "contacts/row", collection: contacts, as: :contact, locals: { page: self }
      end

      def contacts
        @contacts ||= authorized_contact_scope.map {|contact| Exhibit.exhibit_for(view_context, contact) }
      end

      def show_link_with_name(contact)
        link_to contact.name, contact
      end

      def contact_destroy_link(contact)
        link_to "🗑", contact, method: :delete, title: "Delete", data: { confirm: 'Are you sure?' }
      end

      def new_contact_button
        link_to 'New Contact', view_context.new_contact_path, class: "button button--blank"
      end
    end
  end
end
