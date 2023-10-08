class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new()

    if user.has_role?(:admin)
      # Admins can manage all resources
      can :manage, :all
    elsif user.has_role?(:student)
      # Students can manage their own requests
      can :manage, [Request]
      can :read, [Feedback]
      can :read, [Comment]
      # Restrict access to the "RestrictedResource" model
      # Students can't perform any actions on this resource
    elsif user.has_role?(:facilitator)
      # Facilitators can manage their own requests and feedback
      can :manage, [Request, Feedback]
      can :read, [Comment]
      # Restrict access to the "AnotherRestrictedResource" model
      # Facilitators can't perform any actions on this resource
    else
      can :read, :all
    end
  end
end
