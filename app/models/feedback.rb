class Feedback < ApplicationRecord
  belongs_to :request
  validates :content, presence: true
  validates :content, length: { minimum: 10 }
  validates :request_id, presence: true
end
