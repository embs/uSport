class Ability
  include CanCan::Ability

  include ChannelAbility
  include UserAbility
  # include UserChannelAssociationAbility
  include CommentAbility
  include MatchAbility
  include MoveAbility
  include TeamAbility
  include PlayerAbility
  include UserFavoriteChannelAbility

  def initialize(user)
    execute_rules(user)
  end

  protected

  def execute_rules(user)
    # can(:manage, :all) { |obj| obj } if user.try(:is_admin?)

    methods.select { |m| m =~ /.+_abilities$/ }.each do |m|
      send(m, user)
    end
  end
end
