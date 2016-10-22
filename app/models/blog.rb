class Blog < ApplicationRecord
  validates :title, presence: true, length: { maximum: 256 }
  validates :body, presence: true
  validates :summary, presence: true, length: { maximum: 256 }

  scope :published, -> { where.not(published_at: nil) }
  scope :unpublished, -> { where(published_at: nil) }

  def published?
    published_at.present?
  end
end
