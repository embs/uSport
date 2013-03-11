# encoding: utf-8
class MovesController < ApplicationController

  # carrega jogadas de uma partida por javascript
  def index
    @moves = Match.find(params[:match_id]).moves.order('created_at DESC').page(params[:page])
    authorize! :show, Move
    respond_to do |format|
      format.js
    end
  end

  # retorna todos os moves mais recentes que o move com o ID referido além
  # do próprio move
  def show
    @move = Move.find(params[:id])
    authorize! :show, @move
    @moves = Move.where('id > ?', params[:id]).order('created_at DESC')
  end

  def new
    authorize! :manage, Channel.find(params[:channel_id])
    @move = Move.new
    @kinds = [["Punt", "punt"], ["Touchdown", "touchdown"],
      ["Kickoff", "kickoff"], ["Field Goal is Good", "field-goal-is-good"],
      ["Fumble", "fumble"], ["Interceptação", "interceptation"]]
    @minutes = [["--", 0]]
    15.times do |n|
      @minutes << [(n+1).to_s, (n+1)]
    end
    @yards = []
    151.times do |n|
      @yards << [n.to_s, n]
    end
    @match = Match.find(params[:match_id])
  end

  def create
    player = Player.find(params[:move].delete(:player))
    team = Team.find(params[:move].delete(:team))
    @match = Match.find(params[:match_id])
    points = find_points(params[:move][:kind])
    @move = Move.create(params[:move]) do |move|
      move.player = player
      move.team = team
      move.match = @match
      move.points = points
      authorize! :create, move
    end
    # Atualiza o placar da partida
    if team == @match.teams[0]
      @match.value1 = @match.value1 + points
    else
      @match.value2 = @match.value2 + points
    end
    @match.save

    respond_to do |format|
      format.html { render 'create.js.erb' }
      format.js
    end
  end

  def edit
    @move = Move.find(params[:id])
    @match = @move.match
    authorize! :manage, @move
    @kinds = [["Punt", "punt"], ["Touchdown", "touchdown"],
      ["Kickoff", "kickoff"], ["Field Goal is Good", "field-goal-is-good"],
      ["Fumble", "fumble"], ["Interceptação", "interceptation"]]
    @minutes = [["--", 0]]
    15.times do |n|
      @minutes << [(n+1).to_s, (n+1)]
    end
    @yards = []
    151.times do |n|
      @yards << [n.to_s, n]
    end
  end

  def update
    @move = Move.find(params[:id])
    authorize! :manage, @move
    team = Team.find(params[:move].delete(:team))
    player = Player.find(params[:move].delete(:player))
    @move.update_attributes(params[:move]) do |move|
      move.team = team
      move.player = player
    end
    flash[:notice] = 'Jogada atualizada!'
    redirect_to user_channel_match_path(@move.match.channel.owner, @move.match.channel,
      @move.match)
  end

  def destroy
    @move = Move.find(params[:id])
    authorize! :manage, @move
    @move.destroy
    flash[:notice] = 'A jogada foi removida.'
    redirect_to user_channel_match_path(@move.match.channel.owner, @move.match.channel,
      @move.match)
  end

  private

  def find_points(move_kind)
    case move_kind
    when "field-goal-is-good"
      3
    when "touchdown"
      6
    else
      0
    end
  end

end
