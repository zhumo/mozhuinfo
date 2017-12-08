require 'feature_spec_helper'

RSpec.feature 'blogs' do
  include BlogSteps
  include AuthenticationSteps

  let!(:blog) { FactoryBot.create(:blog, :published) }
  let!(:draft) { FactoryBot.create(:blog, :draft) }

  context 'unauthenticated' do
    scenario 'viewing blogs' do
      visit blogs_path
      expect(page).to have_blog_preview(blog)
      expect(page).to_not have_blog_preview(draft) # Does not show drafts to unauthenticated visitors

      # Show
      click_on blog.title
      expect(current_path).to eq(blog_path(blog))
      expect(page).to have_blog(blog)
      click_on 'Back'
      expect(current_path).to eq(blogs_path)

      # Can't create or update
      visit new_blog_path
      expect(current_path).to eq(login_path)
      visit edit_blog_path(blog)
      expect(current_path).to eq(login_path)
    end
  end

  context 'authenticated' do
    before do
      log_in_successfully
    end

    scenario 'blog management' do
      visit blogs_path
      expect(page).to have_blog_preview(blog)
      expect(page).to have_blog_preview(draft)
      within blog_preview(draft) do
        expect(page).to have_draft_icon
      end

      # Show
      click_on blog.title
      expect(current_path).to eq(blog_path(blog))
      expect(page).to have_blog(blog)
      click_on 'Back'
      expect(current_path).to eq(blogs_path)

      # Create blog
      click_on 'New Blog'
      fill_in 'Title', with: 'My Latest Feelings'
      fill_in 'Summary', with: 'I have lots of feelings to share'
      fill_in 'Slug', with: 'feelings'
      fill_in 'Body', with: 'These are my feelings. My feelings are important because I\'m important'
      click_on 'Save'

      latest_blog = Blog.last
      expect(current_path).to eq(blog_path(latest_blog))
      expect(page).to have_blog(latest_blog)
      click_on 'Back'
      expect(page).to have_blog_preview(latest_blog)
      within blog_preview(latest_blog) do
        expect(page).to have_draft_icon
      end

      # Editing
      within blog_preview(latest_blog) do
        click_on 'Edit'
      end
      expect(current_path).to eq(edit_blog_path(latest_blog))
      fill_in 'Title', with: 'Some other shit'
      click_on 'Publish'

      latest_blog.reload
      expect(latest_blog.title).to eq('Some other shit')
      expect(current_path).to eq(blog_path(latest_blog))
      expect(page).to have_blog(latest_blog)
      click_on 'Back'
      expect(page).to have_blog_preview(latest_blog)
      within blog_preview(latest_blog) do
        expect(page).to_not have_draft_icon
      end

      # Deleting
      within blog_preview(latest_blog) do
        click_on 'Delete'
      end
      expect(current_path).to eq(blogs_path)
      expect(page).to_not have_blog_preview(latest_blog)
    end
  end
end
