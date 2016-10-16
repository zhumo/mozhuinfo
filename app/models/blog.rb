class Blog < ActiveRecord::Base
  validates :title, presence: true, length: { maximum: 256 }
  validates :body, presence: true
end
