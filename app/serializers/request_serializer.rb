class RequestSerializer < ActiveModel::Serializer
  attributes :id, :request
  has_one :user
end
