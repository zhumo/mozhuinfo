class Blog < ApplicationRecord
  extend Concerns::StateManagement
  validates :title, presence: true, length: { maximum: 256 }
  validates :body, presence: true
  validates :summary, presence: true, length: { maximum: 256 }

  has_state_for :publish, :published
  alias draft? not_published?
end
