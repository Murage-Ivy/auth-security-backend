class FeedbackSerializer < ActiveModel::Serializer
  attributes :id, :content
  has_one :user
  has_one :request
end
