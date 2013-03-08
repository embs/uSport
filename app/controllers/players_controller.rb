# encoding: utf-8
class PlayersController < ApplicationController

  def new
    authorize! :create, Player
    @player = Player.new
  end

  def create
    authorize! :create, Player
    @player = Player.create(params[:player])
    if @player.valid?
      flash[:notice] = "Jogador criado!"
      redirect_to root_path
    else
      flash[:alert] = "Ops! Não foi possível criar o jogador."
      render 'new'
    end
  end

  def show
    authorize! :show, Player
    @player = Player.find(params[:id])
  end
end