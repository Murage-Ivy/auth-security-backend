class Feedback < ApplicationRecord
  belongs_to :user
  belongs_to :request
  validates :content, presence: true
  validates :content, length: { minimum: 10 }
  validates :user_id, presence: true
  validates :user_id, numericality: { only_integer: true }
  validates :request_id, presence: true
end
