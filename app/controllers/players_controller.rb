# encoding: utf-8
class PlayersController < ApplicationController

  def index
    authorize! :show, Player
    @players = Team.find(params[:team_id]).players
    respond_to do |format|
      format.json do
        render json: @players.collect { |p| "##{p.number} #{p.first_name} #{p.last_name}" }
      end
    end
  end

  def show
    authorize! :show, Player
    @player = Player.find(params[:id])
  end

  def new
    authorize! :create, Player
    @player = Player.new
  end

  def create
    authorize! :create, Player
    @player = Player.create(params[:player])
    if @player.valid?
      flash[:notice] = "Jogador criado!"
      redirect_to teams_path
    else
      flash[:alert] = "Ops! Não foi possível criar o jogador."
      render 'new'
    end
  end

  def edit
    @player = Player.find(params[:id])
    authorize! :manage, @player
  end

  def update
    player = Player.find(params[:id])
    authorize! :manage, player
    player.update_attributes(params[:player])
    if player.save
      flash[:notice] = 'Jogador atualizado!'
    else
      flash[:alert] = 'Ops! Não foi possível atualizar o jogador.'
    end
    redirect_to player_path(player)
  end

  def destroy
    player = Player.find(params[:id])
    authorize! :manage, player
    if player.destroy
      flash[:notice] = 'Jogador removido!'
    else
      flash[:alert] = 'Ops! Não foi possível remover o jogador.'
    end
    redirect_to teams_path
  end
end
