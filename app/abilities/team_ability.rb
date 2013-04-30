module TeamAbility
  extend ActiveSupport::Concern

  def team_abilities(user)
    can :show, Team # Qualquer usuário pode visualizar qualquer time

    if user
      can :create, Team # Qualquer usuário pode criar times
      # Usuários associados ao time podem editá-lo (o que exclui remover)
      can :edit, Team do |team|
        UserTeamAssociation.find_by_user_id_and_team_id(user.id, team.id)
      end
      # Apenas o dono do time pode gerenciá-lo (o que inclui remover)
      can :manage, Team do |team|
        uta = UserTeamAssociation.find_by_user_id_and_team_id(user.id, team.id)
        uta && uta.role.owner?
      end
    end
  end
end
