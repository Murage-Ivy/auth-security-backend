class Comment < ApplicationRecord
  belongs_to :request
  validates :content, presence: true
  validates :content, length: { minimum: 10 }
end
