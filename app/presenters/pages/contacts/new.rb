module Pages
  module Contacts
    class New < Page

      def initialize(view_context)
        initialize_view_context(view_context)
      end

      def render_contact_form
        render 'form', form: form
      end

      delegate :contact_record, :save, to: :form
      alias create save
      def form
        @form ||= Pages::Contacts::Form.new(view_context)
      end

      def back_button
        link_to 'Back', view_context.contacts_path
      end

      def contact
        @contact ||= Exhibit.exhibit_for(view_context, contact_record)
      end

      def after_create_path
        contact.show_path
      end

    end
  end
end
