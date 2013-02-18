class MatchesController < ApplicationController
  layout :choose_layout

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
