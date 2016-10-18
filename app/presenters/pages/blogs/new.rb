module Pages
  module Blogs
    class New < Page

      def initialize(view_context)
        initialize_view_context(view_context)
      end

      def render_blog_form
        render 'form', form: form
      end

      delegate :blog_record, :save, to: :form
      alias create save
      def form
        @form ||= Pages::Blogs::Form.new(view_context)
      end

      def back_button
        link_to 'Back', view_context.blogs_path
      end

      def blog
        @blog ||= Exhibit.exhibit_for(view_context, blog_record)
      end

      def after_create_path
        blog.show_path
      end

    end
  end
end
