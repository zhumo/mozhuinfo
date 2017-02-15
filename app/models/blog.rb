class Blog < ApplicationRecord
  extend Concerns::StateManagement
  validates :title, presence: true, length: { maximum: 256 }
  validates :body, presence: true
  validates :summary, presence: true, length: { maximum: 256 }
  validates :slug, presence: true, length: { maximum: 128 }, uniqueness: true, format: { without: %r{\W} }

  has_state_for :publish, :published
  alias draft? not_published?

  # Blog urls use slug instead of id in the route
  def to_param
    slug
  end
end
