require 'feature_spec_helper'

RSpec.feature 'pings' do
  include AuthenticationSteps
  include PingSteps

  context 'unauthenticated' do
    let(:pm) { FactoryBot.create(:ping) }
    let(:contact) { pm.contact }

    scenario 'ping' do
      expect_authentication_bounce(new_contact_ping_path(contact))
      expect_authentication_bounce(edit_contact_ping_path(contact, pm))
    end
  end

  context 'authenticated' do
    let(:contact) { FactoryBot.create(:contact) }

    before { log_in_successfully }

    scenario 'management' do
      visit contact_path(contact)

      click_on "New Ping"
      expect(current_path).to eq(new_contact_ping_path(contact))

      within ping_form do
        fill_in 'Message', with: 'Happy Birthday'
        select 'Yearly', from: 'Algorithm'
        click_on 'Create Ping'
      end
      expect(current_path).to eq(contact_path(contact))

      pm = contact.pings.last
      within pings_table do
        expect(page).to have_ping(pm)
      end

      within ping_row(pm) do
        click_on 'Edit'
      end
      expect(current_path).to eq(edit_contact_ping_path(contact, pm))

      within ping_form do
        fill_in 'Message', with: 'Merry Christmas!'
        select 'Monthly', from: 'Algorithm'
        click_on 'Update Ping'
      end
      expect(current_path).to eq(contact_path(contact))

      within ping_row(pm) do
        expect(page).to have_text("Monthly")
        expect(page).to have_text("Merry Christmas!")
      end

      within ping_row(pm) do
        click_on 'Delete'
      end
      expect(current_path).to eq(contact_path(contact))

      expect(page).to_not have_pings_table
    end
  end
end
