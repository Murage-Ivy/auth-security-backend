class Facilitator < ApplicationRecord
  has_many :requests, dependent: :destroy
  has_many :feedbacks
end
