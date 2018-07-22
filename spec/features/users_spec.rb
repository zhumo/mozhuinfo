require 'feature_spec_helper'

RSpec.feature 'users' do
  include AuthenticationSteps
  include UserSteps

  context 'unauthenticated' do
    let!(:user) { FactoryBot.create(:user) }

    scenario 'no access at all' do
      expect_authentication_bounce(users_path)
      expect_authentication_bounce(new_user_path)
      expect_authentication_bounce(edit_user_path(user))
    end
  end

  context 'authenticated' do
    before do
      log_in_successfully
    end

    scenario 'user management' do
      visit users_path

      # New
      click_on 'New User'
      fill_in 'Name', with: 'Stacy'
      fill_in 'Phone Number', with: '9998675309'
      click_on 'Save'

      # Show
      stacy = User.last
      expect(current_path).to eq(user_path(stacy))
      expect(page).to have_content('Stacy')
      # TODO: Don't include number helpers in the spec.
      # Wrap this in some kind of page object
      expect(page).to have_content('999-867-5309')

      click_on 'All Users'

      # Index
      expect(current_path).to eq(users_path)
      expect(page).to have_user(stacy)

      # Editing
      within user_row(stacy) do
        click_on 'Edit'
      end
      expect(current_path).to eq(edit_user_path(stacy))
      fill_in 'Name', with: 'Jane'
      fill_in 'Phone Number', with: '0123456789'
      click_on 'Save'

      jane = stacy.reload
      expect(current_path).to eq(user_path(jane))
      expect(page).to have_text('Jane')
      expect(page).to have_text('012-345-6789')
    end
  end
end
