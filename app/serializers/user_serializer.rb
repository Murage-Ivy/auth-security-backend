class UserSerializer < ActiveModel::Serializer
  attributes :id, :email, :role

  def role
    self.object.roles.first.name
  end
end
