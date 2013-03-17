# encoding: utf-8
class FavoriteChannelsController < ApplicationController

  # Mostra os canais favoritos de um usuário
  def index
    authorize! :show, UserFavoriteChannel
    @user = User.find(params[:user_id])
    @favorites = @user.favorite_channels
    if @favorites.empty?
      username = ((current_user && current_user.id == params[:user_id].to_i) ? 'Você' : @user.first_name)
      flash.now[:notice] = "#{username} ainda não possui canais favoritos."
    end
  end

  # Favorita um canal para um usuário
  def create
    authorize! :create, UserFavoriteChannel
    channel = Channel.find(params[:channel_id])
    if current_user.favorite_channels.include?(channel)
      flash[:notice] = 'O canal já faz parte dos seus favoritos.'
    else
      @user_favorite_channel = UserFavoriteChannel.create(user: current_user,
        channel: channel)
      flash[:notice] = 'Canal adicionado aos seus favoritos!'
    end
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
