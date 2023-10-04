class User < ApplicationRecord
  rolify
  has_secure_password
  has_many :refresh_tokens, dependent: :destroy
  validates :password, presence: true
  validates :password, length: { minimum: 6 }
  validates :password, confirmation: true
  validates :confirm_password, presence: true
  validates :email, uniqueness: { case_sensitive: false }
  validates :email, presence: true
  validates :email, format: { with: URI::MailTo::EMAIL_REGEXP }
end
