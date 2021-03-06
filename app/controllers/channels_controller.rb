# encoding: utf-8
class ChannelsController < ApplicationController

  def index
    authorize! :show, Channel
    @channels = user_channels_or_all
  end

  def show
    @channel = Channel.find(params[:id])
    authorize! :show, @channel
  end

  def new
    @channel = Channel.new
    authorize! :create, @channel
  end

  def create
    authorize! :create, Channel
    @channel = current_user.channels.build(params[:channel])
    @channel.owner = current_user
    if @channel.save
      current_user.channels << @channel
      flash[:notice] = 'Seu canal está pronto para transmitir!'
      redirect_to channel_path(@channel)
    else
      flash.now[:error] = 'Ops! Não foi possível criar o canal.'
      render 'new'
    end
  end

  def edit
    @channel = Channel.find(params[:id])
    authorize! :edit, @channel
  end

  def update
    @channel = Channel.find(params[:id])
    authorize! :edit, @channel
    # Cria nova UserChannelAssociation se for necessário
    if params[:collaborator] && !params[:collaborator][:username].empty?
      user = User.find_by_username(params[:collaborator][:username])
      unless user
        flash.now[:error] = 'Ops! Não encontramos o colaborador que você tentou adicionar.'
        render 'edit' and return
      end
      UserChannelAssociation.create(user: user, channel: @channel)
    end
    if @channel.update_attributes(params[:channel])
      flash[:notice] = 'Os dados do canal foram atualizados.'
      redirect_to channel_path(@channel)
    else
      flash.now[:error] = 'Ops! Não foi possível atualizar o canal.'
      render 'edit'
    end
  end

  def destroy
    @channel = Channel.find(params[:id])
    authorize! :destroy, @channel
    @channel.destroy
    flash[:notice] = 'O canal foi removido.'
    redirect_to root_path
  end

  private

  # Retorna somente os canais de um usuário especificado por params[:user_id] ou
  # retorna todos os canais se o params[:user_id] não for especificado
  def user_channels_or_all
    if params[:user_id]
      @active_page = "UserChannels"
      User.find(params[:user_id]).channels
    else
      @active_page = "Channels"
      Channel.all
    end
  end
end
