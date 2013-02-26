# encoding: utf-8
class MatchesController < ApplicationController
  layout :choose_layout

  def new
    authorize! :manage, Channel.find(params[:channel_id])
    @match = FootballMatch.new #FIXME Por enquanto, apenas partidas desse tipo
    authorize! :create, Match
    @teams = Team.all
  end

  def create
    channel = Channel.find(params[:channel_id])
    authorize! :manage, channel
    teams = params[:football_match].delete(:teams_ids) if params[:football_match][:teams_ids]
    @teams = Team.all
    @match = Match.new(params[:football_match]) do |m|
      m.teams << Team.find(teams) if teams
      m.channel = channel
    end
    if @match.save
      flash[:notice] = 'Partida criada!'
      redirect_to user_channel_match_path(current_user.id, channel.id, @match.id)
    else
      flash[:alert] = @match.errors
      render 'new'
    end
  end

  def show
    @match = Match.find(params[:id])
    authorize! :show, @match
    @user = User.find(params[:user_id])
    @moves = @match.moves.order('created_at DESC')
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
