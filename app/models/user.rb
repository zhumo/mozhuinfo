class User < ApplicationRecord

  has_many :programmatic_messages, dependent: :destroy

  validates :name,
    presence: true,
    uniqueness: true,
    length: { maximum: 128 }
  validates :phone_number,
    presence: true,
    uniqueness: { case_sensitive: false },
    format: {
      with: /\A\d{10}\z/,
      message: "must be ten digits, with no spaces or other characters",
    }
end
