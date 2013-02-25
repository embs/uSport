module ChannelAbility
  extend ActiveSupport::Concern

  def channel_abilities(user)
    can :show, Channel # Qualquer usuário pode visualizar qualquer canal

    # Somente usuários logados podem:
    if user
      can :create, Channel # Criar um canal

      can :manage, Channel do |channel| # Gerenciar canal
        channel.owner == user # Se o canal for dele
      end
    end
  end
end
