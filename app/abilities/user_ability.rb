module UserAbility
  extend ActiveSupport::Concern

  def user_abilities(user)
    can :show, User

    # Qualquer usuário pode gerenciar a si mesmo
    if user
      can :manage, User do |u|
        u.id == user.id
      end
    end
  end
end
