module MatchAbility
  extend ActiveSupport::Concern

  def match_abilities(user)
    can :show, Match # Qualquer usuário pode visualizar qualquer partida

    if user
      can :create, Match do |match|
        match.channel.owner == user
      end

      can :manage, Match do |match|
        match.channel.owner == user 
      end
    end
  end
end
