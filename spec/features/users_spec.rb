require 'feature_spec_helper'

RSpec.feature 'users' do
  include AuthenticationSteps

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

      # Index
      stacy = User.last
      expect(current_path).to eq(users_path)
      expect(page).to have_user(stacy)

      # Editing
      within user_block(stacy) do
        click_on 'Edit'
      end
      expect(current_path).to eq(edit_user_path(stacy))
      fill_in 'Name', with: 'Jane'
      fill_in 'Phone Number', with: '0123456789'
      click_on 'Save'

      expect(current_path).to eq(users_path)
      expect(page).to have_text('Jane')
      expect(page).to have_text('0123456789')
    end
  end
end
