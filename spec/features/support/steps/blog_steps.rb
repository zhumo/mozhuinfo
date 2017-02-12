module BlogSteps

  def blog_preview_selector(blog)
    ".blog-preview[data-blog-id='#{blog.id}']"
  end

  def blog_preview(blog)
    find(blog_preview_selector(blog))
  end

  def have_blog_preview(blog)
    have_selector(blog_preview_selector(blog))
  end

  def have_blog(blog)
    have_selector(".blog[data-blog-id='#{blog.id}']")
  end

  def have_draft_icon
    have_selector('.blog__draft-icon')
  end
end
