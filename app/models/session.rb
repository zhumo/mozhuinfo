class Session < ApplicationRecord
  validates :token, presence: true, length: { maximum: 128 }
end
