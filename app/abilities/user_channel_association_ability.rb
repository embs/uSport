module UserChannelAssociationAbility
  extend ActiveSupport::Concern

  def user_channel_association_abilities(user)
    can :show, UserChannelAssociation

    if user
      can :create, UserChannelAssociation do |uca|
        uca.channel.owner == user
      end

      can :manage, UserChannelAssociation do |uca|
        uca.channel.owner == user && user != uca.user
      end
    end
  end
end
