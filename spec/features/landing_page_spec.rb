require 'rails_helper'

RSpec.feature 'Landing Page' do
  scenario 'visiting' do
    visit root_path
  end
end
