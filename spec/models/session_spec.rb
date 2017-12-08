require 'rails_helper'

RSpec.describe Session, type: :model do
  it { should validate_presence_of(:token) }
  it { should validate_length_of(:token).is_at_most(128) }

  describe '#active?' do
    context 'active' do
      subject(:session) { FactoryBot.create(:session) }

      it { should be_active }
    end

    context 'expired' do
      subject(:session) { FactoryBot.create(:session, :expired) }

      it { should_not be_active }
    end
  end
end
