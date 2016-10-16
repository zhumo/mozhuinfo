module Exhibits
  class Blog < Exhibit
    exhibit_model :blog

    delegate :title, :body, to: :blog_record

    def preview
      truncate(body, length: 100)
    end

    def full_body
      body
    end

    def show_path
      route_path(:blog, blog_record)
    end
    alias delete_path show_path

    def edit_path
      route_path(:edit_blog, blog_record)
    end

  end
end
