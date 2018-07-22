class ProgrammaticMessage < ActiveRecord::Base
  belongs_to :user

  validates :user, presence: true
  validates :algorithm, presence: true, length: { maximum: 128 }, inclusion: { in: [] }
  validates :body, presence: true, length: { maximum: 128 }
end
