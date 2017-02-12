module Pages
  module Blogs
    class Index < Page

      def initialize(view_context)
        initialize_view_context(view_context)
      end

      def render_blog_summaries
        render partial: 'blogs/blog_preview', collection: blogs, as: :blog, locals: { page: self }
      end

      def blogs
        @blogs ||= authorized_blog_scope.map do |blog_record|
          Exhibit.exhibit_for(view_context, blog_record)
        end
      end

      def new_blog_button
        link_to 'New Blog', route_path(:new_blog), class: 'button button--blank'
      end

      def blog_title_link(blog)
        link_to blog.title, blog.show_path
      end

      def read_more_button(blog)
        link_to 'Read more...', blog.show_path
      end

      def edit_blog_button(blog)
        link_to 'Edit', blog.edit_path
      end

      def delete_blog_button(blog)
        link_to 'Delete', blog.delete_path, method: :delete, data: { confirm: 'Are you sure?' }
      end
    end
  end
end
