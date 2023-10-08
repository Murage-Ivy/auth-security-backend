class RequestSerializer < ActiveModel::Serializer
  attributes :id, :request, :facilitator
  has_one :user

  def facilitator
    self.object.facilitator.email
  end

  has_many :feedbacks
  has_many :comments
end
