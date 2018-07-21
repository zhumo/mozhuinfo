require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'validations' do
    subject { FactoryBot.build(:user) }

    # Name
    it { should validate_uniqueness_of(:name) }
    it { should validate_presence_of(:name) }
    it { should validate_length_of(:name).is_at_most(128) }

    # Phone Number
    it { should validate_uniqueness_of(:phone_number).case_insensitive }
    it { should validate_presence_of(:phone_number) }
    it { should have_valid(:phone_number).when("1234567890") }
    it { should_not have_valid(:phone_number).when("123456789o") }
    it { should_not have_valid(:phone_number).when("1234567890asdfghj") }
  end
end
