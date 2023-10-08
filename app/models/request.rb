class Request < ApplicationRecord
  belongs_to :user
  belongs_to :facilitator
  has_many :comments, dependent: :destroy
  has_many :feedbacks, dependent: :destroy
  validates :request, presence: true
  validates :request, length: { minimum: 10 }
  validates :user_id, presence: true
  validates :user_id, numericality: { only_integer: true }
end
