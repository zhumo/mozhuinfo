module Pages
  module Contacts
    class Edit < Page

      attr_reader :contact_record
      def initialize(view_context, contact_record)
        initialize_view_context(view_context)
        @contact_record = contact_record
      end

      def render_contact_form
        render 'form', form: form
      end

      delegate :save, to: :form
      alias update save
      def form
        @form ||= Pages::Contacts::Form.new(view_context, contact_record)
      end

      def contact
        @contact ||= Exhibit.exhibit_for(view_context, contact_record)
      end

      def after_update_path
        contact
      end

      def cancel_link
        link_to 'Cancel', contact
      end

    end
  end
end
