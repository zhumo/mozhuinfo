class Blog < ApplicationRecord
  validates :title, presence: true, length: { maximum: 256 }
  validates :body, presence: true

  def published?
    published_at.present?
  end
end
