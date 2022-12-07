# frozen_string_literal: true

class Ability
  include CanCan::Ability


  def initialize(user)
    user ||= User.new # guest user (not logged in)


    if user.owner? and user.client?
      can :manage, User, id: user.id # Only owner can update his own profile
      can :manage, Aircraft, user: user # Only owner can update his own aircraft
      can :create, Aircraft # Only owner can create new aircraft
      can :read, Aircraft
      can :read, Booking
      can :read, EmptyLeg
      can [:read, :update], Booking, aircraft: { user: user }
      can :create, Booking
      can :update, EmptyLeg, aircraft: { user: user }
      can :create, EmptyLeg
      can :read, ReviewAircraft
      can :create, Feedback
      can :manage, User, id: user.id
      can [:read, :update], Booking, user: user
      can :create, Booking
      can :read, EmptyLeg
      can :create, ReviewAircraft
      can :update, ReviewAircraft, user: user
      can :read, Aircraft
      can :create, Feedback
    elsif user.owner?
      can :manage, User, id: user.id # Only owner can update his own profile
      can :manage, Aircraft, user: user # Only owner can update his own aircraft
      can :create, Aircraft # Only owner can create new aircraft
      can :read, Aircraft
      can :read, EmptyLeg
      can [:read, :update], Booking, aircraft: { user: user }
      can :read, Booking 
      can :update, EmptyLeg, aircraft: { user: user }
      can :create, EmptyLeg
      can :read, ReviewAircraft
      can :create, Feedback
    elsif user.client?
      can :manage, User, id: user.id
      can [:read, :update], Booking, user: user
      can :create, Booking
      can :read, EmptyLeg
      can :create, ReviewAircraft
      can :update, ReviewAircraft, user: user
      can :read, Aircraft
      can :create, Feedback
    else # guest user (not logged in)
      can :read, Aircraft
      can :read, EmptyLeg
      can :read, Booking
      can :read, ReviewAircraft
      can :read, Feedback
      can :create, Feedback
    end
  end
end
