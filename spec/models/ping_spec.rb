require 'rails_helper'

RSpec.describe Ping, type: :model do

  # Associations
  it { should belong_to(:user) }

  # User
  it { should validate_presence_of(:user) }

  # body
  it { should validate_presence_of(:message) }
  it { should validate_length_of(:message).is_at_most(128) }

  # Al Gore Rhythm
  it { should validate_presence_of(:algorithm) }
  it { should validate_length_of(:algorithm).is_at_most(128) }
  it { should validate_inclusion_of(:algorithm).in_array(ProgrammaticMessage::VALID_ALGORITHMS) }

  describe 'paused state' do
    it_should_behave_like Concerns::StateManagement, :pause, :paused
  end
end
