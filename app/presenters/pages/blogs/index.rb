module Pages
  module Blogs
    class Index < Page

      def initialize(view_context)
        initialize_view_context(view_context)
      end

      def render_blog_summaries
        render_collection blogs, 'blogs/blog_summary', page: self do |local_assigns, blog|
          local_assigns[:blog] = blog
        end
      end

      def blogs
        @blogs ||= Blog.all.map do |blog_record|
          Exhibit.exhibit_for(view_context, blog_record)
        end
      end

      def new_blog_button
        link_to 'New Blog', route_path(:new_blog)
      end

      def show_blog_button(blog)
        link_to 'Show', blog.show_path
      end

      def edit_blog_button(blog)
        link_to 'Edit', blog.edit_path
      end

      def delete_blog_button(blog)
        link_to 'Delete', blog.delete_path, method: :delete
      end
    end
  end
end
