# encoding: utf-8
class MovesController < ApplicationController

  def new
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
    player_id = params[:move].delete(:player)
    team_id = params[:move].delete(:team)
    Move.create(params[:move]) do |move|
      move.player = Player.find(player_id)
      move.team = Team.find(team_id)
      move.match = Match.find(params[:match_id])
    end
    redirect_to new_user_channel_match_move_path
  end

end
