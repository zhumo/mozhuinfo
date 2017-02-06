require 'rails_helper'

RSpec.describe Session do
  it { should validate_presence_of(:token) }
  it { should validate_length_of(:token).is_at_most(128) }
end
