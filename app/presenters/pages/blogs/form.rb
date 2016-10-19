module Pages
  module Blogs
    class Form < Page
      attr_reader :blog_record

      def initialize(view_context, blog_record = nil)
        initialize_view_context(view_context)
        @blog_record = blog_record || build_blog_record
      end

      def render_form(&block)
        form_for(@blog_record, &block)
      end

      def render_errors(f)
        render 'shared/form_errors', errors: f.object.errors
      end

      def build_blog_record
        Blog.new
      end

      def save(blog_params)
        blog_record.assign_attributes(blog_params)
        blog_record.save
      end
    end
  end
end
