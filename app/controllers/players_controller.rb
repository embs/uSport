# encoding: utf-8
class PlayersController < ApplicationController

  def index
    authorize! :show, Player
    @players = Team.find(params[:team_id]).players
    respond_to do |format|
      format.json do
        render json: @players.collect { |p| "##{p.number} #{p.first_name}" }
      end
    end
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

  def show
    authorize! :show, Player
    @player = Player.find(params[:id])
  end
end
