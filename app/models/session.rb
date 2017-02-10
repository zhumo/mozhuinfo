class Session < ApplicationRecord
  validates :token, presence: true, length: { maximum: 128 }

  def active?
    created_at > 1.week.ago
  end
end
