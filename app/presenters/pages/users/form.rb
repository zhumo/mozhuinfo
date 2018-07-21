module Pages
  module Users
    class Form < Page
      attr_reader :user_record

      def initialize(view_context, user_record = nil)
        initialize_view_context(view_context)
        @user_record = user_record || build_user_record
      end

      def render_form(&block)
        form_for(@user_record, &block)
      end

      def render_errors(f)
        render 'shared/form_errors', errors: f.object.errors
      end

      def build_user_record
        User.new
      end

      def save(user_params)
        user_record.assign_attributes(user_params)
        user_record.save
      end
    end
  end
end
