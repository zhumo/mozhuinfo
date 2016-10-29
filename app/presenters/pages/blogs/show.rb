module Pages
  module Blogs
    class Show < Page

      attr_reader :blog_record

      delegate :title, :preview, :full_body, :draft?, :timestamp, to: :blog

      def initialize(view_context, blog_record)
        initialize_view_context(view_context)
        @blog_record = blog_record
      end

      def blog
        @blog ||= Exhibit.exhibit_for(view_context, blog_record)
      end

      def edit_blog_button
        link_to 'Edit', blog.edit_path
      end

      def back_button
        link_to 'Back', view_context.blogs_path
      end
    end
  end
end
