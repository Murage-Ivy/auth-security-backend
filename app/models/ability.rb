# frozen_string_literal: true

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
    elsif user.has_role?(:facilitator)
      # Facilitators can manage their own requests and feedback
      can :manage, [Request, Feedback]
    else
      can :read, :all
    end
  end
end