class User < ApplicationRecord
  has_secure_password
  rolify
  has_many :refresh_tokens, dependent: :destroy
  has_many :requests, dependent: :destroy
  validates :password, presence: true
  validates :password, length: { minimum: 6 }
  validates :password, confirmation: true
  validates :password_confirmation, presence: true
  validates :email, uniqueness: true
  validates :email, presence: true
  validates :email, format: { with: URI::MailTo::EMAIL_REGEXP }
end
