module Pages
  module Users
    class New < Page

      def initialize(view_context)
        initialize_view_context(view_context)
      end

      def render_user_form
        render 'form', form: form
      end

      delegate :user_record, :save, to: :form
      alias create save
      def form
        @form ||= Pages::Users::Form.new(view_context)
      end

      def back_button
        link_to 'Back', view_context.users_path
      end

      def user
        @user ||= Exhibit.exhibit_for(view_context, user_record)
      end

      def after_create_path
        user.show_path
      end

    end
  end
end
