class Writer < ApplicationRecord
  validates :display_name, presence: true, length: { maximum: 128 }
  validates :full_name, presence: true, length: { maximum: 128 }
  validates :password_digest, presence: true, length: { maximum: 128 }

  has_secure_password
end
