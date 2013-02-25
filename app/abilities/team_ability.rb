module TeamAbility
  extend ActiveSupport::Concern

  def team_abilities(user)
    can :show, Team # Qualquer usuário pode visualizar qualquer jogada

    if user
      can :create, Team # Qualquer usuário pode criar times
      can :manage, Team # Qualquer usuário pode gerenciar times
    end
  end
end
