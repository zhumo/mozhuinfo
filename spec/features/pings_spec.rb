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

      click_on "New ping"
      expect(current_path).to eq(new_user_ping(user))

      within ping_form do
        fill_in 'Body', with: 'Happy Birthday'
        select 'Annual', from: 'Algorithms'
        click_on 'Create'
      end
      expect(current_path).to eq(user_path(user))

      pm = user.pings.last
      within pings_list do
        expect(page).to have_ping(pm)
      end

      within_ping_row(pm) do
        click_on 'Edit'
      end
      expect(current_path).to eq(edit_user_ping_path(user, pm))

      within ping_row(pm) do
        click_on 'Delete'
      end
      expect(current_path).to eq(user_path(user))
      within ping_list do
        expect(page).to_not have_ping(pm)
      end
    end
  end
end
