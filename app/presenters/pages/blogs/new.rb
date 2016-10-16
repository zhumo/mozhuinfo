module Pages
  module Blogs
    class New < Page

      def initialize(view_context)
        initialize_view_context(view_context)
      end

      def render_blog_form
        render 'form', form: form
      end

      delegate :save, to: :form
      alias create save
      def form
        @form ||= Pages::Blogs::Form.new(view_context)
      end

      def back_button
        link_to 'Back', view_context.blogs_path
      end

      def after_create_path
        form.blog.show_path
      end

    end
  end
end
