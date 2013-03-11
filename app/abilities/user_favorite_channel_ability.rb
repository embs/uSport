module UserFavoriteChannelAbility
  extend ActiveSupport::Concern

  def user_favorite_channel_abilities(user)
    can :show, UserFavoriteChannel # Qualquer usuário pode visualizar favoritos

    # Qualquer usuário logado pode
    if user
      can :create, UserFavoriteChannel # Adicionar um canal a seus favoritos

      can :manage, UserFavoriteChannel do |fav| # Gerenciar seus favoritos
        fav.user == user
      end
    end
  end
end
