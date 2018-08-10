require 'feature_spec_helper'

RSpec.feature 'contacts' do
  include AuthenticationSteps
  include ContactSteps

  context 'unauthenticated' do
    let!(:contact) { FactoryBot.create(:contact) }

    scenario 'no access at all' do
      expect_authentication_bounce(contacts_path)
      expect_authentication_bounce(new_contact_path)
      expect_authentication_bounce(edit_contact_path(contact))
    end
  end

  context 'authenticated' do
    before do
      log_in_successfully
    end

    scenario 'contact management' do
      visit contacts_path

      # New
      click_on 'New Contact'
      fill_in 'Name', with: 'Stacy'
      fill_in 'Phone Number', with: '9998675309'
      click_on 'Save'

      # Show
      stacy = Contact.last
      expect(current_path).to eq(contact_path(stacy))
      expect(page).to have_content('Stacy')
      # TODO: Don't include number helpers in the spec.
      # Wrap this in some kind of page object
      expect(page).to have_content('999-867-5309')

      click_on 'All Contacts'

      # Index
      expect(current_path).to eq(contacts_path)
      expect(page).to have_contact(stacy)

      # Editing
      within contact_row(stacy) do
        click_on stacy.name
      end
      click_on 'Edit'
      expect(current_path).to eq(edit_contact_path(stacy))
      fill_in 'Name', with: 'Jane'
      fill_in 'Phone Number', with: '0123456789'
      click_on 'Save'

      jane = stacy.reload
      expect(current_path).to eq(contact_path(jane))
      expect(page).to have_text('Jane')
      expect(page).to have_text('012-345-6789')
    end
  end
end
