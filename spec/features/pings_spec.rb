require 'feature_spec_helper'

RSpec.feature 'pings' do
  include AuthenticationSteps
  include PingSteps

  context 'unauthenticated' do
    let(:pm) { FactoryBot.create(:ping) }
    let(:user) { pm.user }

    scenario 'ping' do
      expect_authentication_bounce(new_user_ping_path(user))
      expect_authentication_bounce(edit_user_ping_path(user, pm))
    end
  end

  context 'authenticated' do
    let(:user) { FactoryBot.create(:user) }

    before { log_in_successfully }

    scenario 'management' do
      visit user_path(user)

      click_on "New Ping"
      expect(current_path).to eq(new_user_ping_path(user))

      within ping_form do
        fill_in 'Message', with: 'Happy Birthday'
        select 'Yearly', from: 'Algorithm'
        click_on 'Create Ping'
      end
      expect(current_path).to eq(user_path(user))

      pm = user.pings.last
      within pings_table do
        expect(page).to have_ping(pm)
      end

      within ping_row(pm) do
        click_on 'Edit'
      end
      expect(current_path).to eq(edit_user_ping_path(user, pm))

      within ping_form do
        fill_in 'Message', with: 'Merry Christmas!'
        select 'Monthly', from: 'Algorithm'
        click_on 'Update Ping'
      end
      expect(current_path).to eq(user_path(user))

      within ping_row(pm) do
        expect(page).to have_text("Monthly")
        expect(page).to have_text("Merry Christmas!")
      end

      within ping_row(pm) do
        click_on 'Delete'
      end
      expect(current_path).to eq(user_path(user))

      expect(page).to_not have_pings_table
    end
  end
end
