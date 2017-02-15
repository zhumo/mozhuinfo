require 'rails_helper'

RSpec.describe Blog, type: :model do
  describe 'validations' do
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
  end

  describe 'published state' do
    it_should_behave_like Concerns::StateManagement, :publish, :published
  end
end
