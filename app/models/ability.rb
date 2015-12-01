class Ability
  include CanCan::Ability

  def initialize(user)

    if user.has_role? :admin
        can :manage, :all
    
    end

    if user.has_role? :logist
        can :read, Factory
        can :create, Factory
        can :update, Factory
        
        can :read, Delivery
        can :create, Delivery
        can :update, Delivery

    end

    if user.has_role? :manager
        # can :manage,:all
        can :read, Project
        can :create, Project
        can :update, Project

        can :read, Specification
        can :create, Specification
        can :update, Specification

        can :read, TableSpecification
        can :create, TableSpecification
        can :update, TableSpecification
        
        can :read, Product
        can :create, Product
        can :update, Product
        
        can :read, Photo
        can :create, Photo
        can :update, Photo
        
        can :read, SizeImage
        can :create, SizeImage
        can :update, SizeImage

        # can :create, Factory
        # can :read, Delivery

    end
        
    if user.has_role? :company_moderator
        can :read, Project
        can :create, Project
        can :update, Project

        can :read, Specification
        can :create, Specification
        can :update, Specification

        can :read, TableSpecification
        can :create, TableSpecification
        can :update, TableSpecification
        
        can :read, Product
        can :create, Product
        can :update, Product

        can :read, Photo
        can :create, Photo
        can :update, Photo
        
        can :read, SizeImage
        can :create, SizeImage
        can :update, SizeImage
        
        can :read, Company
        can :create, Company
        can :update, Company

        can :read, Client
        can :create, Client
        can :update, Client

        can :read, City
        can :create, City
        can :update, City

        can :read, Style
        can :create, Style
        can :update, Style

        can :read, TypeFurniture
        can :create, TypeFurniture
        can :update, TypeFurniture
       
    end    

    # -----
    # if user.has_role? :admin

    #     can :manage, :all

    # if user.has_role? :logist

    #     can :manage, :all
    #     # can :update, Factory do |brand|
    #     #     brand.user == user 
    #     # end
    #     # can :write, 
    #     # can :create, Factory
 
    # else
    #     can :read, :Project
    #     # can :manage, User, :id => user.id

    #     can :update, Factory do |brand|
    #         brand.user == user 
    #     end

    #     can :destroy, Factory do |brand|
    #         brand.user == user 
    #     end

    #     can :update, Project do |project|
    #         project.user == user 
    #     end

    #     can :destroy, Project do |project|
    #         project.user == user 
    #     end

    #     can :read, Project do |project|
    #         project.user == user 
    #     end
        
    #     can :update, Specification do |specification|
    #         specification.user == user 
    #     end

    #     can :destroy, Specification do |specification|
    #         specification.user == user 
    #     end

    #     can :update, TableSpecification do |table_specification|
    #         table_specification.user == user 
    #     end

    #     can :destroy, TableSpecification do |table_specification|
    #         table_specification.user == user 
    #     end

    #     can :create, Factory
    #     can :create, Project
    #     can :create, Specification
    #     can :create, TableSpecification
    #     # end
    # end
    # # Define abilities for the passed in user here. For example:
    #
    #   user ||= User.new # guest user (not logged in)
    #   if user.admin?
    #     can :manage, :all
    #   else
    #     can :read, :all
    #   end
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
  end
end
