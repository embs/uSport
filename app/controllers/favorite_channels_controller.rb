class FavoriteChannelsController < ApplicationController

  # Mostra os canais favoritos de um usuário
  def index
    authorize! :show, UserFavoriteChannel
    @user = User.find(params[:user_id])
    @favorites = @user.favorite_channels
  end

  # Favorita um canal para um usuário
  def create
    authorize! :create, UserFavoriteChannel
    @user_favorite_channel = UserFavoriteChannel.create(user: current_user,
      channel: Channel.find(params[:channel_id]))
    flash[:notice] = 'Canal adicionado aos seus favoritos!'
    redirect_to user_favorite_channels_path(current_user)
  end

  # Remove canal favorito de um usuário
  def destroy
    @user_favorite_channel = UserFavoriteChannel.find_by_user_id_and_channel_id(
      current_user, Channel.find(params[:channel_id]))
    authorize! :manage, @user_favorite_channel
    @user_favorite_channel.destroy
    flash[:notice] = 'O canal foi removido dos seus favoritos.'
    redirect_to user_favorite_channels_path(current_user)
  end
end
