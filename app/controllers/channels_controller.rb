# encoding: utf-8
class ChannelsController < ApplicationController

  def index
    @channels = Channel.all
  end

  def show
    @channel = Channel.find(params[:id])
  end

  def new
    @channel = Channel.new
  end

  def create
    @channel = Channel.new(params[:channel])
    @channel.owner = current_user
    if @channel.save
      flash[:notice] = 'Seu canal está pronto para transmitir!'
      redirect_to user_channel_path(@channel.owner, @channel)
    else
      flash.now[:error] = 'Ops! Não foi possível criar o canal.'
      render 'new'
    end
  end

  def edit
    @channel = Channel.find(params[:id])
  end

  def update
    @channel = Channel.find(params[:id])
    if @channel.update_attributes(params[:channel])
      flash[:notice] = 'Os dados do canal foram atualizados.'
      redirect_to user_channel_path(@channel.owner, @channel)
    else
      flash.now[:error] = 'Ops! Não foi possível atualizar o canal.'
      render 'edit'
    end
  end

  def destroy
    @channel = Channel.find(params[:id])
    @channel.destroy
    flash[:notice] = 'O canal foi removido.'
    redirect_to root_path
  end
end
