class BlogsController < ApplicationController
  def index
    @page = Pages::Blogs::Index.new(view_context)
  end

  def show
    @page = BlogShowPage.new(view_context, blog_record)
  end

  def new
    @page = NewBlogPage.new(view_context)
  end

  def edit
    @page = EditBlogPage.new(view_context, blog_record)
  end

  def create
    @page = NewBlogPage.new(view_context)

    if @page.create(blog_params)
      redirect_to @page.after_create_path, notice: 'Blog was successfully created.'
    else
      render :new
    end
  end

  def update
    @page = EditBlogPage.new(view_context, blog_record)

    if @page.update(blog_params)
      redirect_to @page.after_update_path, notice: 'Blog was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    blog_record.destroy
    redirect_to blogs_url, notice: 'Blog was successfully destroyed.'
  end

  private
  def blog_record
    @blog ||= Blog.find(params[:id])
  end

  def blog_params
    params.require(:blog).permit(:title, :body)
  end
end
