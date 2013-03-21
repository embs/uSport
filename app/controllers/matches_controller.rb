# encoding: utf-8
class MatchesController < ApplicationController
  layout :choose_layout

  def show
    @match = Match.find(params[:id])
    authorize! :show, @match
    # @user = User.find(params[:user_id])
    @moves = @match.moves.order('created_at DESC').page(params[:page])
    # Daqui para baixo são setadas as variáveis utilizadas para criação de move
    @move = Move.new(:match => @match)
    if can?(:create, @move)
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
  end

  def new
    authorize! :manage, Channel.find(params[:channel_id])
    @match = FootballMatch.new #FIXME Por enquanto, apenas partidas desse tipo
    authorize! :create, Match
    @teams = Team.all # necessário para formulário de criação
  end

  def create
    channel = Channel.find(params[:channel_id])
    authorize! :manage, channel
    teams = params[:football_match].delete(:teams_ids) if params[:football_match][:teams_ids]
    @teams = Team.all
    @match = FootballMatch.new(params[:football_match]) do |m|
      m.teams << Team.find(teams) if teams
      m.channel = channel
    end
    if @match.save
      flash[:notice] = 'Partida criada!'
      redirect_to match_path(@match)
    else
      flash.now[:alert] = 'Ops! Não foi possível criar a partida.'
      render 'new'
    end
  end

  def edit
    @match = Match.find(params[:id])
    @teams = Team.all # necessário para formulário de edição
    authorize! :manage, @match
  end

  def update
    match = Match.find(params[:id])
    authorize! :manage, match
    teams = params[:football_match].delete(:teams_ids) if params[:football_match][:teams_ids]
    match.update_attributes(params[:football_match])
    match.teams = Team.find(teams) if teams
    if match.save
      flash[:notice] = 'Partida atualizada!'
    else
      flash[:error] = 'Ops! Não foi possível atualizar a partida.'
    end

    redirect_to match_path(match)
  end

  def score
    @match = Match.find(params[:id])
  end

  private

  def choose_layout
    if action_name == "score"
      "clean"
    else
      "application"
    end
  end

end
