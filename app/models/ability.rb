class Ability
  include CanCan::Ability

  def initialize(user)
    # The 'user' argument to initialize will generally be 'current_user' if you've defined it
    # in your controller (See Awesome Answers 'application controller')

    # Define abilities for the passed in user here. For example:
    #
      user ||= User.new # guest user (not logged in)
       if user.is_admin?
         can :manage, :all
       else
         can :read, :all
       end

       
    #
    # The first argument to `can` is the action you are giving the user
    # permission to do.
    # If you pass :manage it will apply to every action. Other common actions
    # here are :read, :create, :update and :destroy.
    #
    # The second argument is the resource the user can perform the action on.
    # If you pass :all it will apply to every resource. Otherwise pass a Ruby
    # class of the resource.
    #
    # The third argument is an optional hash of conditions to further filter the
    # objects.
    # For example, here the user can only update published articles.
    #
    #   can :update, Article, :published => true
    #
    # See the wiki for details:
    # https://github.com/CanCanCommunity/cancancan/wiki/Defining-Abilities

    # In this rule, we're saying that te user can 'manage' meaning they can perform any CRUD operation on the resource Question.
    # The user that is allowed to do this is the owner of teh question as shown by 'question.user == user'
    can :manage, Question do |question|
      question.user == user
    end

    can :manage, Answer do |answer|
      answer.user== user
    end

    

  end
end
