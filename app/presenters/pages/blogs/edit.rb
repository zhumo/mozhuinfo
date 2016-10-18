module Pages
  module Blogs
    class Edit < Page

      attr_reader :blog_record

      def initialize(view_context, blog_record)
        initialize_view_context(view_context)
        @blog_record = blog_record
      end

      def render_blog_form
        render 'form', form: form
      end

      delegate :save, to: :form
      alias update save
      def form
        @form ||= Pages::Blogs::Form.new(view_context, blog_record)
      end

      def blog
        @blog ||= Exhibit.exhibit_for(view_context, blog_record)
      end

      def after_update_path
        blog.show_path
      end

      def back_button
        link_to 'Back', view_context.blogs_path
      end
    end
  end
end
