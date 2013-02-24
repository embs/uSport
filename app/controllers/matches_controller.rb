class MatchesController < ApplicationController
  layout :choose_layout

  def new
    @match = FootballMatch.new #FIXME Por enquanto, apenas partidas desse tipo
    @teams = Team.all
  end

  def create
    teams = params[:match].delete(:teams)
    match = Match.new(params[:match])
    match.channel = Channel.find(params[:channel_id])
    match.teams << Team.find(teams.first)
    match.teams << Team.find(teams.last)
    match.date = params[:match][:date]
    match.save
    redirect_to user_channel_match_path(current_user.id, params[:channel_id].to_i, match.id)
  end

  def show
    @match = Match.find(params[:id])
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
