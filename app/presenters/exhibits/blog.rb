module Exhibits
  class Blog < Exhibit
    exhibit_model :blog

    def preview
      summary
    end

    def full_body
      markdown(body)
    end

    def timestamp(format = :month_day_year)
      if published?
        "Published #{published_at.to_formatted_s(format)}"
      else
        "Created #{created_at.to_formatted_s(format)}"
      end
    end

    def show_path
      route_path(:blog, blog_record)
    end
    alias delete_path show_path

    def edit_path
      route_path(:edit_blog, blog_record)
    end

    class << self
      def applicable_to?(object)
        # Simply calling Blog here refers to itself. Need to return to root namespace
        # in order to refer to the Blog model
        object.is_a?(::Blog)
      end
    end

  end
end
