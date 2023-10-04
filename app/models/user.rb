class User < ApplicationRecord
  has_secure_password
  rolify
  has_many :refresh_tokens, dependent: :destroy
  validates :password, presence: true
  validates :password, length: { minimum: 6 }
  validates :password, confirmation: true
  validates :password_confirmation, presence: true
  validates :email, uniqueness: true
  validates :email, presence: true
end
