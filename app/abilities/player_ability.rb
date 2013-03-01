module PlayerAbility
  extend ActiveSupport::Concern

  def player_abilities(user)
    can :show, Player # Qualquer usuário pode visualizar qualquer jogador

    if user # Só usuários logados podem
      can :create, Player # Criar
      can :manage, Player # e gerenciar jogadores
    end
  end
end
