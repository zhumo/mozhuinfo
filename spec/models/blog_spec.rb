require 'rails_helper'

RSpec.describe Blog, type: :model do
  describe 'validations' do
    subject { FactoryGirl.build(:blog) }
    # Title
    it { should validate_presence_of(:title) }
    it { should validate_length_of(:title).is_at_most(256) }

    # Body
    it { should validate_presence_of(:body) }

    # Summary
    it { should validate_presence_of(:summary) }
    it { should validate_length_of(:summary).is_at_most(256) }

    # Slug
    it { should validate_presence_of(:slug) }
    it { should validate_length_of(:slug).is_at_most(128) }
    it { should validate_uniqueness_of(:slug) }
    it { should have_valid(:slug).when('abc_123') }
    it { should_not have_valid(:slug).when('abc_123_<>":{}!@#') }
  end

  describe 'published state' do
    it_should_behave_like Concerns::StateManagement, :publish, :published
  end
end
