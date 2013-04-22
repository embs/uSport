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

    respond_to do |format|
      format.html
      format.js
    end
  end

  def new
    @match = Match.find(params[:match_id])
    authorize! :manage, @match
    @move = Move.new
    @kinds = [
      ["Punt", "punt"],
      ["Extrapoint", "extrapoint"],
      ["Penalty", "penalty"],
      ["Kickoff", "kickoff"],
      ["Fumble", "fumble"],
      ["Tackle", "tackle"],
      ["Run", "run"],
      ["Turnover", "turnover"],
      ["Time", "time"],
      ["Touchdown (Corrida)", "touchdown-run"], ["Touchdown (Retorno)", "touchdown"],
      ["Touchdown (Passe)", "touchdown-pass"],
      ["Fieldgoal", "fieldgoal"],
      ["Pass", "pass"],
      ["Sack", "sack"],
      ["Interception", "interception"]]
    @minutes = [["--", 0]]
    15.times do |n|
      @minutes << [(n+1).to_s, (n+1)]
    end
    @yards = []
    (-50..50).to_a.each do |n|
      @yards << [n.to_s, n]
    end
  end

  def create
    team = Team.find(params[:move].delete(:team))
    unless params[:move][:kind] == 'comment' || params[:move][:kind] == 'end'
      player = team.find_player_by_text_input(params[:move][:player])
    end
    params[:move].delete(:player)
    @match = Match.find(params[:match_id])
    points = find_points(params[:move][:kind])
    unless player
      authorize! :manave, Move.new(match: @match)
      render js: "$('#player input').val(''); $('#player input').attr('placeholder', 'Informe um jogador válido'); $('#player input').focus();" and return
    end
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

    begin
      Pusher.trigger("match-#{@match.id}", 'new-move',
        {
          val1: @match.value1, val2: @match.value2,
          move: @move.id
        })
    rescue Pusher::Error => e
      #TODO
    end

    respond_to do |format|
      format.html { render 'create.js.erb' }
      format.js
    end
  end

  def edit
    @move = Move.find(params[:id])
    @match = @move.match
    authorize! :manage, @move
    @kinds = [
      ["Punt", "punt"],
      ["Extrapoint", "extrapoint"],
      ["Penalty", "penalty"],
      ["Kickoff", "kickoff"],
      ["Fumble", "fumble"],
      ["Tackle", "tackle"],
      ["Run", "run"],
      ["Turnover", "turnover"],
      ["Time", "time"],
      ["Touchdown", "touchdown"],
      ["Fieldgoal", "fieldgoal"],
      ["Pass", "pass"],
      ["Sack", "sack"],
      ["Interception", "interception"]
    ]
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
    player = Player.find_by_text_input(params[:move].delete(:player))
    @move.update_attributes(params[:move])
    @move.player = player
    @move.team = team
    if @move.save
      flash[:notice] = 'Jogada atualizada!'
      redirect_to match_path(@move.match)
    else
      flash.now[:alert] = 'Não foi possível atualizar a jogada. Verifique os dados.'
      render 'edit'
    end
  end

  def destroy
    @move = Move.find(params[:id])
    team = @move.team
    @match = @move.match
    points = find_points(@move.kind)
    authorize! :manage, @move
    # Atualiza o placar da partida
    if team == @match.teams[0]
      @match.value1 = @match.value1 - points
    else
      @match.value2 = @match.value2 - points
    end
    @match.save
    @move.destroy
    respond_to do |format|
      format.html do
        flash[:notice] = 'A jogada foi removida.'
        redirect_to match_path(@move.match)
      end
      format.js
    end
  end

  private

  def find_points(move_kind)
    case move_kind
    when "fieldgoal"
      3
    when "touchdown"
      6
    else
      0
    end
  end

end
