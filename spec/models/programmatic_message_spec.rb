require 'rails_helper'

RSpec.describe ProgrammaticMessage, type: :model do

  # Associations
  it { should belong_to(:user) }

  # User
  it { should validate_presence_of(:user) }

  # body
  it { should validate_presence_of(:body) }
  it { should validate_length_of(:body).is_at_most(128) }

  # Al Gore Rhythm
  it { should validate_presence_of(:algorithm) }
  it { should validate_length_of(:algorithm).is_at_most(128) }
  it { should validate_inclusion_of(:algorithm).in_array([]) }

end
