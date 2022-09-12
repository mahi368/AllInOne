class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new
     #can :read, Category
    if user.present?
      if user.has_role? :admin
        can :manage, Category
        can :manage, :all
      else
        can :read, Category
      end
    end
  end
end
