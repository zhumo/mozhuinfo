module Pages
  module Users
    class Edit < Page

      attr_reader :user_record
      def initialize(view_context, user_record)
        initialize_view_context(view_context)
        @user_record = user_record
      end

      def render_user_form
        render 'form', form: form
      end

      delegate :save, to: :form
      alias update save
      def form
        @form ||= Pages::Users::Form.new(view_context, user_record)
      end

      def user
        @user ||= Exhibit.exhibit_for(view_context, user_record)
      end

      def after_update_path
        user
      end

      def cancel_link
        link_to 'Cancel', user
      end

    end
  end
end
