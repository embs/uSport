module ChannelsHelper
  def show_heart_if_favorite(user, channel)
    if channel.is_favorite_of?(user)
      '<i class="icon-heart channel-avatar" data-toogle="tooltip"
        data-placement="top" data-original-title="Canal Favorito"></i>'
    else
      ''
    end
  end
end
