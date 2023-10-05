class Request < ApplicationRecord
  belongs_to :user
  has_many :feedbacks, dependent: :destroy
  validates :request, presence: true
  validates :request, length: { minimum: 10 }
  validates :user_id, presence: true
  validates :user_id, numericality: { only_integer: true }
end
