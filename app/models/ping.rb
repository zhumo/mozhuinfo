class Ping < ActiveRecord::Base
  extend Concerns::StateManagement
  belongs_to :contact

  VALID_ALGORITHMS = [
    YEARLY_ALGORITHM = "yearly",
    MONTHLY_ALGORITHM = "monthly",
  ]

  validates :contact, presence: true
  validates :algorithm,
    presence: true,
    length: { maximum: 128 },
    inclusion: { in: VALID_ALGORITHMS }
  validates :message, presence: true, length: { maximum: 128 }

  has_state_for :pause, :paused
end
