module MoveAbility
  extend ActiveSupport::Concern

  def move_abilities(user)
    can :show, Move # Qualquer usuário pode visualizar qualquer jogada

    if user
      can :create, Move do |move|
        move.match.channel.owner == user
      end

      can :manage, Move do |move|
        move.match.channel.owner == user || move.match.channel.users.include?(user)
      end
    end
  end
end
