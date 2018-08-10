module Pages
  module Contacts
    class Form < Page
      attr_reader :contact_record

      def initialize(view_context, contact_record = nil)
        initialize_view_context(view_context)
        @contact_record = contact_record || build_contact_record
      end

      def render_form(&block)
        form_for(@contact_record, &block)
      end

      def render_errors(f)
        render 'shared/form_errors', errors: f.object.errors
      end

      def build_contact_record
        Contact.new
      end

      def save(contact_params)
        contact_record.assign_attributes(contact_params)
        contact_record.save
      end
    end
  end
end
