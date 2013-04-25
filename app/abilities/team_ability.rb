module TeamAbility
  extend ActiveSupport::Concern

  def team_abilities(user)
    can :show, Team # Qualquer usuário pode visualizar qualquer time

    if user
      can :create, Team # Qualquer usuário pode criar times
      # Apenas usuários associados ao time podem gerenciá-lo
      can :manage, Team do |team|
        UserTeamAssociation.find_by_user_id_and_team_id(user.id, team.id)
      end
    end
  end
end
