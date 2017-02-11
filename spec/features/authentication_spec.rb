require 'feature_spec_helper'

RSpec.feature 'signing in' do
  include AuthenticationSteps

  context 'incorrect credentials' do
    it 'fails' do
      attempt_login('something', 'wrong')
      expect(current_path).to eq(login_path)
    end
  end

  context 'correct credentials' do
    it 'succeeds' do
      log_in_successfully
    end
  end
end

RSpec.feature 'logging out' do
  include AuthenticationSteps

  scenario 'it logs out' do
    log_in_successfully
    log_out_location = current_path
    click_on 'Log Out'
    expect(current_path).to eq(log_out_location)
  end
end
