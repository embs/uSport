# encoding: utf-8
class MovesController < ApplicationController

  # carrega jogadas de uma partida por javascript
  def index
    @moves = Match.find(params[:match_id]).moves.includes(:team, :match, :player).
      order('created_at DESC').page(params[:page])
    authorize! :show, Move
    respond_to do |format|
      format.js
    end
  end

  def new
    @match = Match.find(params[:match_id])
    authorize! :manage, @match
    @move = Move.new
    @kinds = [["Punt", "punt"], ["Extrapoint", "extrapoint"], ["Penalty", "penalty"],
      ["Kickoff", "kickoff"], ["Fumble", "fumble"], ["Tackle", "tackle"],
      ["Run", "run"], ["Turnover", "turnover"], ["Time", "time"],
      ["Touchdown (Corrida)", "touchdown-run"], ["Touchdown (Retorno)", "touchdown"],
      ["Touchdown (Passe)", "touchdown-pass"], ["Fieldgoal", "fieldgoal"],
      ["Pass", "pass"], ["Sack", "sack"], ["Interception", "interception"],
      ["Safety", "safety"], ["Two-point conversion", "two-point-conversion"],
      ["Comentário", "comment"], ["Fim de Jogo", "end"]]
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
    @match = Match.find(params[:match_id])
    unless ['comment', 'end', 'time'].include?(params[:move][:kind])
      player = team.find_player_by_text_input(params[:move][:player])
      authorize! :manage, Move.new(match: @match)
      unless player
        render js: "$('#player input').val(''); $('#player input').attr('placeholder', 'Informe um jogador válido'); $('#player input').focus();" and return
      end
    end
    params[:move].delete(:player)
    points = Move.points_for(params[:move][:kind])
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
    @kinds = [["Punt", "punt"], ["Extrapoint", "extrapoint"], ["Penalty", "penalty"],
      ["Kickoff", "kickoff"], ["Fumble", "fumble"], ["Tackle", "tackle"],
      ["Run", "run"], ["Turnover", "turnover"], ["Time", "time"],
      ["Touchdown (Corrida)", "touchdown-run"], ["Touchdown (Retorno)", "touchdown"],
      ["Touchdown (Passe)", "touchdown-pass"], ["Fieldgoal", "fieldgoal"],
      ["Pass", "pass"], ["Sack", "sack"], ["Interception", "interception"],
      ["Safety", "safety"], ["Two-point conversion", "two-point-conversion"],
      ["Comentário", "comment"], ["Fim de Jogo", "end"]]
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
    team = Team.find(params[:move].delete(:team)) if params[:move][:team]
    if params[:move][:player]
      player = Player.find_by_text_input(params[:move].delete(:player))
    end
    @move.update_attributes(params[:move])
    @move.player = player if player
    @move.team = team if team
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
    points = Move.points_for(@move.kind)
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

  def vote
    @move = Move.find(params[:move_id])
    authorize! :show, @move
    @move.liked_by current_user

    respond_to do |format|
      format.js
    end
  end
end
